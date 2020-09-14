+++
Author = "Radhi Fadlillah"
CreateTime = 2018-09-28T22:26:24+07:00
Tags = ["linux", "systemd", "tutorial", "vps", "sysadmin"]
Title = "Creating a Basic Linux Service Using Systemd"
+++

When I started deploying web app on my server, I ran it using `nohup` instead of running it as a service. I did it because I thought making a service is hard. Apparently, I was wrong.

Since Ubuntu server uses Systemd, there are several steps to create and start a service. First of all, create a `service` file in `/etc/systemd/system`. For example here I want to run Caddy as a service, so I create file named `caddy.service` with following content :

```
[Unit]
Description=Starts the Caddy server
Requires=network.target
After=network.target

[Service]
Type=simple
User=radhi
Restart=always
RestartSec=3
WorkingDirectory=/home/radhi/caddy
ExecStart=/home/radhi/go/bin/caddy

[Install]
WantedBy=multi-user.target
```

Once finished, save it, then reload Systemd configuration by running :

```
sudo systemctl daemon-reload
```

After it finished, we can enable and start the service by running :

```
sudo systemctl enable caddy
sudo systemctl start caddy
```
