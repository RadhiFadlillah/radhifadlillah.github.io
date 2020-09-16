+++
Author = "Radhi Fadlillah"
CreateTime = 2019-06-23T22:20:39+07:00
Tags = ["tutorial", "vps", "linux", "caddy", "sysadmin", "webserver"]
Title = "Build Caddy from Source in 2019"
+++

Since my [previous](/post/2018-08-19-build-caddy-from-source) tutorial in 2018, there are many changes and improvement in Caddy Server. One of the improvement is the building process now far easier than before.

In the past, to build Caddy with several plugins installed, we need to modify Caddy's source code. This is not exactly easy, especially for beginner. Today, thanks to Go module, we can easily do it without modifying the source code.

For example, here we will build Caddy with [dns.cloudflare](https://github.com/caddyserver/dnsproviders/tree/master/cloudflare) plugin which allows you to obtain certificates using DNS records for domains managed with Cloudflare. Before you start, make sure Go 1.12 or newer already installed on your system. 

### Building Caddy and Its Plugins

First, create a new folder anywhere and create a Go file with following content:

```go
package main

import (
    // The main Caddy server
	"github.com/caddyserver/caddy/caddy/caddymain"
	
	// Caddy plugins, use underscore as import name
	_ "github.com/caddyserver/dnsproviders/cloudflare"
)

func main() {
	caddymain.Run()
}
```

Next, initiate the folder as Go module named `caddy`:

```
go mod init caddy
```

After that, add and update Caddy as module dependency:

```
go get -u github.com/caddyserver/caddy
```

Now we just need to install it by running `go install` which will put `caddy` in `$GOPATH/bin`.

### Run Caddy

As web server, Caddy will need the access to port 80 (HTTP) and 443 (HTTPs). To do so, we need to let Caddy to listen to port < 1024 by running :

```bash
sudo setcap cap_net_bind_service=+ep $GOPATH/bin/caddy
```

Next we need to increase the maximum number of open files in our server. To do this, we need to increase the limit of file descriptor by running :

```bash
ulimit -n 8192
```

Now we could run Caddy in background as the web server. There are several ways to do this. We can use `nohup` and `cron` to run Caddy in background when the server start. To do this, first open the `cron` configuration file by running :

```bash
crontab -e
```

Next add these lines to the end of file :

```bash
@reboot . $HOME/.profile && nohup caddy -conf "/path/to/Caddyfile" >> ~/Caddy.log 2>&1 &
```

We can also create Caddy as system [service](/post/2018-09-28-create-a-service-systemd/) which might be more preferrable for most people.
