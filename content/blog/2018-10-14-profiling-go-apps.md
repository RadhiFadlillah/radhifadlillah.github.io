+++
Author = "Radhi Fadlillah"
CreateTime = 2018-10-14T21:34:32+07:00
Tags = ["go", "golang"]
Title = "Profiling Go Apps"
+++

There are several ways for profiling a Go application, but the easiest one that I've found is by using `github.com/pkg/profile`.

To use it, first install it by running :

```bash
go get github.com/pkg/profile
```

Once installed, enable the profiler by starting it in the main function of your app :

```go
package main

import "github.com/pkg/profile"

func main() {
// Use this line for profiling CPU
defer profile.Start().Stop()

// Use this line for profiling memory
defer profile.Start(profile.MemProfile).Stop()
}
```

Next, build and run your app like usual. Once finished, the app will generate a `pprof` file in a temporary folder, and it will tell you where it's located, for example :

```bash
2018/10/1414:26:28 profile: cpu profiling enabled, /var/...../cpu.pprof
```

If you use memory profiler, the output will be `mem.pprof` instead of `cpu.pprof`.

To analyze the `pprof` file, we can convert it to PDF file by using standard Go tool :

```bash
go tool pprof --pdf ~/go/bin/yourbinary /path/to/cpu.pprof > file.pdf
```
