+++
Author = "Radhi Fadlillah"
CreateTime = 2020-09-10T17:20:06+07:00
Tags = ["tutorial", "golang"]
Title = "Build Go Programs Statically"
+++

I always thought Go compiles program statically as long as we only use pure Go. So, in theory I could create an app, compile it, then run the executable binary anywhere without requiring any shared dependencies. However, several hours ago my app crashed in my server with following error :

```
/usr/local/go/pkg/tool/linux_amd64/6g: /lib64/libc.so.6: version `GLIBC_2.32' not found
```

So, this issue is happened because my Ubuntu LTS server still uses `GLIBC 2.27` while my workstation is using rolling release distro (Manjaro) that already uses `GLIBC 2.32`. However, I was sure that my code doesn't use any cgo code, so this issue shouldn't happened.

After looking around, I found out that Go has two packages in the standard library that use cgo, i.e. `os/user` and `net`. To fix this, we can use `osusergo` and `netgo` build tags to skip building the cgo parts from those packages :

```
go build -tags "osusergo netgo"
```

For more details you might want to check blog [post][1] by [Martin Tournoij][2] (archived locally [here][3]). He explains in details why those packages uses cgo and how to statically link cgo package like SQLite.

[1]: https://www.arp242.net/static-go.html
[2]: https://github.com/arp242
[3]: /assets/2020-09-10-build-static-go/arp242-archive.html