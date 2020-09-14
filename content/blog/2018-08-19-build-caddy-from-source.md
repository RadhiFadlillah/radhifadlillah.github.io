+++
Author = "Radhi Fadlillah"
CreateTime = 2018-08-19T17:13:27+07:00
Tags = ["tutorial", "vps", "linux", "caddy", "sysadmin", "webserver"]
Title = "Step by Step: Build Caddy From the Source"
UpdateTime = 2018-08-22T06:54:45+07:00
+++

After finished [setting up](/post/2018-08-18-setting-up-a-new-vps) my VPS, next I want to install [Caddy](https://caddyserver.com) as my web server. Even though Caddy is still quite new, I prefer using it rather than the existing web server like Apache or Nginx. The reasons are :

- It's the only web server that uses HTTPS by default.
- It's easy to configure. For example, to enable HTTPs we only need to write 3-line configuration file.
- Because it's written in Go, it's only use single binary without any dependencies, which make it really easy to install.
- It's production ready and has been [used](https://caddyserver.com/stats) by many people.

While Caddy already provides a [precompiled](https://caddyserver.com/download) binary, it's only free for personal use. In other hand, I still don't have the privilege to pay the monthly payment for the commercial license. Fortunately, that limitation only implemented for the precompiled binary. That means we still can use Caddy for free even for commercial use, as long as we built it from the source.

### Table of Contents

1. [Install Go](#install-go)
2. [Download Caddy and Its Plugin](#download-caddy-and-its-plugin)
3. [Build Caddy](#build-caddy)
4. [Run Caddy](#run-caddy)

### Install Go

First, [download](https://golang.org/dl/) the latest Go version to your VPS. When this post is written, the latest version is 1.10.3 :

```bash
wget https://dl.google.com/go/go1.10.3.linux-amd64.tar.gz
```

Next, extract the downloaded file into `/usr/local`, creating a Go tree in `/usr/local/go` :

```bash
sudo tar -C /usr/local -xzf go1.10.3.linux-amd64.tar.gz
```

Add `/usr/local/go/bin` to the `PATH` environment variable, either in your `/etc/profile` (for a system-wide installation) or `$HOME/.profile`. Open the profile file using `nano` or your preferred editor, then add these lines to the end of file :

```bash
export PATH=$PATH:/usr/local/go/bin
```

For conveniance, you should add the Go workspace's `bin` subdirectory to your `PATH` to let you run the compiled Go program directly. Open the profile file again then add following lines :

```bash
export GOPATH=$(go env GOPATH)
export PATH=$PATH:$GOPATH/bin
```

Once finished, save and close the profile file. To apply the change, run `source` to your profile file :

```bash
source $HOME/.profile
```

Now, `go` should be installed on your system. To test it, run `go env` which should give you output like this :

```bash
GOARCH="amd64"
GOBIN=""
GOCACHE="/home/radhi/.cache/go-build"
GOEXE=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOOS="linux"
GOPATH="/home/radhi/go"
GORACE=""
GOROOT="/usr/local/go"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GCCGO="gccgo"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build238814194=/tmp/go-build -gno-record-gcc-switches"
```

### Download Caddy and Its Plugin

To build Caddy from source, run these commands :

```bash
go get -u -v github.com/mholt/caddy/caddy
go get -u -v github.com/caddyserver/builds
```

Next download the plugin that you want to use. In my case, I will use these plugins :

- [git](https://github.com/abiosoft/caddy-git), the git plugin that make it possible to deploy a site with a simple git push.
- [dns.cloudflare](https://github.com/caddyserver/dnsproviders/tree/master/cloudflare), which allows you to obtain certificates using DNS records for domains managed with Cloudflare.

To download these plugins, run :

```bash
go get -u -v github.com/abiosoft/caddy-git
go get -u -v github.com/caddyserver/dnsproviders/cloudflare
```

### Build Caddy

Before building Caddy, we have to include the plugins to the Caddy's source code. First, set working directory to Caddy's directory :

```bash
cd $GOPATH/src/github.com/mholt/caddy/caddy
```

Next, open the `caddymain/run.go` and add imports link for packages of the plugins that you want to install :

```go
_ "github.com/abiosoft/caddy-git"
_ "github.com/caddyserver/dnsproviders/cloudflare"
```

Save and close the file. Next, still in the `caddy` directory, build Caddy by running :

```bash
go install
```

Once finished, you can run Caddy by using `caddy` command.

### Run Caddy

As web server, Caddy will need the access to port 80 (HTTP) and 443 (HTTPs). To do so, we need to let Caddy to listen to port < 1024 by running :

```bash
sudo setcap cap_net_bind_service=+ep $GOPATH/bin/caddy
```

Next we need to increase the maximum number of open files in our server. To do this, we need to increase the limit of file descriptor by running :

```bash
ulimit -n 8192
```

Now we could run Caddy in background as the web server. There are several ways to do this. First is by making Caddy as service for init system. The second one is easier, by using `nohup &`. The full command is like this :

```bash
nohup caddy -conf "/path/to/Caddyfile" >> ~/Caddy.log 2>&1 &
```

The command above will run `caddy` in background and put the log file in `$HOME/Caddy.log`. To make Caddy run when the server start, you can use the [cron](https://en.wikipedia.org/wiki/Cron) job. To do this, first open the configuration file by running :

```bash
crontab -e
```

Next add these lines to the end of file :

```bash
@reboot . $HOME/.profile && nohup caddy -conf "/path/to/Caddyfile" >> ~/Caddy.log 2>&1 &
```

Save and close the configuration file. The `@reboot` syntax means the command in that line will be run after every reboot on the system. The `. $HOME/.profile` is used to load environment variable that defined by the profile file. This is done because `cron` is started before the `.profile` file is loaded, so we need to load it manually.

### Finished

At this point, Caddy has been installed on your system and will run automatically when system starts. You should check the [documentation](https://caddyserver.com/docs) to learn how to create Caddyfile and activate the HTTPs for your site.
