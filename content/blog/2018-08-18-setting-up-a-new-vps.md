+++
Author = "Radhi Fadlillah"
CreateTime = 2018-08-18T14:51:18+07:00
Tags = ["tutorial", "vps", "linux", "ubuntu", "sysadmin"]
Title = "Step by Step: Setting Up a New VPS"
+++

I've bought a new VPS from [Vultr](https://www.vultr.com/) for my own data server. This post is documentation of the steps that I took on setting up my new VPS. The OS that used in VPS is Ubuntu 18.04 64-bit, while OS in my local machine is Manjaro 64-bit.

### Table of Contents

1. [Setup SSH in local machine](#setup-ssh-in-local-machine)
2. [Login to the VPS via SSH as root](#login-to-the-vps-via-ssh-as-root)
3. [Change root password](#change-root-password)
4. [Create a new user](#create-a-new-user)
5. [Enable Public Key Authentication](#enable-public-key-authentication)
6. [Disable Password Authentication and log in as root](#disable-password-authentication-and-log-in-as-root) 
7. [Set up firewall](#set-up-firewall) 
8. Bonus: [Install MariaDB](#install-mariadb)

### Setup SSH in local machine

Make sure SSH is installed in the local machine. If it's not, install it by running :

```bash
sudo pacman -S openssh
```

After installation finished, create a new SSH keys by running :

```bash
ssh-keygen
```

Suppose the name of user in local machine is `localuser`. The command above will show message like this :

```bash
Generating public/private rsa key pair.
Enter file in which to save the key (/Users/localuser/.ssh/id_rsa):
```

Click enter to save SSH keys in the default location. After that, we will be asked to input a password to secure the generated keys. You are free to submit the password or not, but in this tutorial I don't use any password. Once the process finished, in `$HOME/.ssh` directory will be generated private key `id_rsa` and public key `id_rsa.pub`.

SSH keys are important because it's provide a more secure way of logging into a server with SSH than using a password alone. While a password can eventually be cracked with a brute force attack, SSH keys are nearly impossible to decipher by brute force alone. Not to mention it makes login process easier because you don't have to input the password every time. If you're unsure whether you already have an SSH key or not, you can check if directory `$HOME/.ssh` is exists.

### Login to the VPS via SSH as root

Open the terminal, then input this command :

```bash
ssh root@<ip-vps>
```

After that, SSH will show a warning message and ask you to confirm the authenticity of the host. Answer `yes` to the warning message, then input password for the root user. If the password is correct, we will given access to VPS as root user.

Once in, update the system by running `apt update` followed by `apt upgrade`. If necessary, reboot the VPS by running `reboot`.

### Change root password

When we buy a new VPS on Vultr, we will given a default SSH password to access VPS as root. For safety reason, you should change the default password to a new one. You can do it by running `passwd`, then input your new password.

### Create a new user

For the next steps, we need to create a new user. For example, here we create a new user with the name `radhi` :

```bash
adduser radhi
```

After that, system wil ask us to input data and password for new user :

```bash
Adding user `radhi' ...
Adding new group `radhi' (1000) ...
Adding new user `radhi' (1000) with group `radhi' ...
Creating home directory `/home/radhi' ...
Copying files from `/etc/skel' ...
New password: 
Retype new password: 
passwd: password updated successfully
Changing the user information for radhi
Enter the new value, or press ENTER for the default
	Full Name []: Radhi Fadlillah
	Room Number []:  
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n] y
```

To let the new user performs administrative commands (e.g. installing new application), the new user must be included in `sudo` group (which is the "administrators" group in Linux). To do that, run :

```bash
usermod -aG sudo radhi
```

Once it finished, user `radhi` can run administrative commands by using `sudo` command.

### Enable Public Key Authentication

As mentioned before, public key authentication provides SSH users with the convenience of logging in to their VPS without entering their passwords. Not to mention it is a lot more safer than using password.

To enable it, we have to upload public key in the local machine to the VPS. To do that, log out from VPS, then run :

```bash
ssh-copy-id radhi@<ip-vps>
```

While sending the public key, we will asked to input the password of user in VPS (in this case is `radhi`) . Once finished, system will show success message like this :

```bash
Number of key(s) added: 1

Now try logging into the machine, with:   "ssh radhi@<ip-vps>"
and check to make sure that only the key(s) you wanted were added.
```

Now log in back to server by running `ssh radhi@<ip-vps>`, and you should be able to do it without submitting the password.

### Disable Password Authentication and log in as root

To prevent brute force attack, it's recommended to disable password authentication for log in. For same reason, login as root user should be disabled as well because almost certainly brute force attack will try to use it. To do it, log in to VPS as our new user (in this tutorial is `radhi`), then edit SSH configuration by running `nano` (or your preferred text editor) :

```bash
sudo nano /etc/ssh/sshd_config
```

Find the line for `PasswordAuthentication`:

```bash
#PasswordAuthentication yes
```

Remove the hash symbol, then set the value to `no` :

```bash
PasswordAuthentication no
```

After that, to make only `radhi` that can log in to the VPS, add this line to the end of file :

```bash
AllowUsers radhi
```

Save the file, then reload SSH daemon by running :

```bash
sudo service ssh restart
```

Now nobody can't log in to the VPS by using password or as root user. Instead, only `radhi` using Public Key Authentication that can access the VPS from SSH.

### Set up firewall

Firewall is a must for a server. There are several firewall available for Linux, e.g. `iptables`, `csf` and `ufw`. I will use `ufw` because IMO it's the simplest one between those three.

UFW (Uncomplicated Firewall) is an interface to `iptables` that is geared towards simplifying the process of configuring a firewall, which make it suitable for beginner. To use it, install it by running :

```bash
sudo apt install ufw
```

Since modern VPS supports IPv6, we have to make sure UFW able to support it. To do this, open the UFW configuration using `nano` (or your preferred editor) :

```bash
sudo nano /etc/default/ufw
```

Then find line `IPV6` and set its value to `yes`:

```bash
IPV6=yes
```

Save, then close the file. Now, when UFW is enabled, it will protecting all network traffic both from IPv4 and IPv6.

Next, we need to set default policies for all network traffics. Here, we want the VPS to allow all outgoing connection, but deny all incoming transmission. This way, server can send data to any connection, but doesn't let any connection to connect to server. To do this, run :

```bash
sudo ufw default allow outgoing
sudo ufw default deny incoming
```

Next, we need permission to allow several type of connection to server. Usually, there are three types of connection that must be allowed, i.e. SSH, HTTP and HTTPs :

```bash
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
```

To see all added rules, run :

```bash
sudo ufw show added
```

To remove one of firewall rules, you can use `ufw delete`. For example, here we want to revoke permission for HTTP access :

```bash
sudo ufw delete allow http
```

Before activating UFW, we have to make sure that UFW can be used in our VPS. You might need to install other packages like `python` or `iptables`. To check it, you can run :

```bash
sudo /usr/share/ufw/check-requirements
```

If the check finished successfully, it means we can activate the firewall. Before activating it, make sure you already allow SSH connection in the firewall. If you don't activate it, you won't be able to log in to the VPS anymore, so make sure it's allowed. To activate it, run :

```bash
sudo ufw enable
```

Now, UFW has been activated. You can check the status of UFW by running :

```bash
sudo ufw status verbose
```

If you decide you don't want to use UFW, you can disable it with this command :

```bash
sudo ufw disable
```

If you want to reset all UFW rules that has been made, run :

```bash
sudo ufw reset
```

### Install MariaDB

[MariaDB](https://mariadb.org/) is one of the most popular database management system. It's easy, popular, and used by many application. That's why I'm including it in this tutorial. 

Ubuntu includes MariaDB 10.1 in its main repositories. However, the lates stable version of MariaDB is 10.3, so I will use that one. To do it, we need to add MariaDB repositories to our system. To do this, open download page of [MariaDB](https://downloads.mariadb.org/mariadb/repositories/), then choose OS, version and your preferred mirror location. For example, here we choose :

- OS: Ubuntu 18.04 LTS
- Version: 10.3
- Mirror: DigitalOcean - Singapore, SG

To add the MariaDB repositories, run :

```bash
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
sudo add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://sgp1.mirrors.digitalocean.com/mariadb/repo/10.3/ubuntu bionic main'
```

If `add-apt-repository` is not available in your VPS, install it by running :

```bash
sudo apt install software-properties-common
```

Once the key is imported and the repository added, you can install MariaDB 10.3 by running :

```bash
sudo apt update
sudo apt install mariadb-server -y
```

While installing, we might be asked to input the password for root. If not, root will be given empty password. Once finished, we have to secure MariaDB by running :

```bash
sudo mysql_secure_installation
```

Here we will be asked about several point, e.g. about root password, etc :

```bash
NOTE: RUNNING ALL PARTS OF THIS SCRIPT IS RECOMMENDED FOR ALL MariaDB
      SERVERS IN PRODUCTION USE!  PLEASE READ EACH STEP CAREFULLY!

In order to log into MariaDB to secure it, we'll need the current
password for the root user.  If you've just installed MariaDB, and
you haven't set the root password yet, the password will be blank,
so you should just press enter here.

Enter current password for root (enter for none): 
OK, successfully used password, moving on...

Setting the root password ensures that nobody can log into the MariaDB
root user without the proper authorisation.

You already have a root password set, so you can safely answer 'n'.

Change the root password? [Y/n] n
 ... skipping.

By default, a MariaDB installation has an anonymous user, allowing anyone
to log into MariaDB without having to have a user account created for
them.  This is intended only for testing, and to make the installation
go a bit smoother.  You should remove them before moving into a
production environment.

Remove anonymous users? [Y/n] y
 ... Success!

Normally, root should only be allowed to connect from 'localhost'.  This
ensures that someone cannot guess at the root password from the network.

Disallow root login remotely? [Y/n] y
 ... Success!

By default, MariaDB comes with a database named 'test' that anyone can
access.  This is also intended only for testing, and should be removed
before moving into a production environment.

Remove test database and access to it? [Y/n] y
 - Dropping test database...
 ... Success!
 - Removing privileges on test database...
 ... Success!

Reloading the privilege tables will ensure that all changes made so far
will take effect immediately.

Reload privilege tables now? [Y/n] y
 ... Success!

Cleaning up...

All done!  If you've completed all of the above steps, your MariaDB
installation should now be secure.

Thanks for using MariaDB!
```

Now we can use MariaDB by running :

```bash
sudo mysql -p
```
