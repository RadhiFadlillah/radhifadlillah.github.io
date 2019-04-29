+++
Title = "Setting a Printer Without Using Password in Manjaro"
Excerpt = ""
CreatedAt = "2019-04-10 15:57:43 +0700"
UpdatedAt = "2019-04-10 15:57:43 +0700"
Category = "tutorial"
Tags = ["linux", "tutorial"]
Author = "Radhi Fadlillah"
+++

When setting up a printer for my office, I realize that `system-config-printer` in Manjaro requires user to input the root password to add or modify a printer. It won't allow users to do anything, until the root user unlock it :

![Printer settings need to be unlocked first](printer-need-password.png)

While it's fine for a personal computer, it's not really desirable for a shared workstation. To fix this, we need to make `system-config-printer` can be run as a root, but without inputting any password. To do so, we need to edit `sudoers` file in `/etc/sudoers` :

```
sudo nano /etc/sudoers
```

Next add following line to the end of file :

```
<username> ALL=NOPASSWD: /usr/bin/system-config-printer
```

Replace that `<username>` with your name, then save the file. Make sure you add a new line below it, because without it `sudo` won't be able to parse the `sudoers` file :

![Add new line at the end of the file](add-new-line.png)

Next, modify the application's menu (in Manjaro, it's called Whisker Menu) so the printer setting will be run as a root using `sudo` :

![Modify the menu so system-config-printer will be run as root](modify-start-menu.png)

Once finished, printer setting should be accessible without requiring any password from the users :

![Printer settings can be used without password](printer-no-password.png)
