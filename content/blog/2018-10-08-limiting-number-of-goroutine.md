+++
Author = "Radhi Fadlillah"
CreateTime = 2018-10-08T18:58:12+07:00
Description = "While scraping some data from website, I found out that some websites will deny your request if there are too many concurrent requests. To fix this, we need to limit number of goroutine that run at a time."
Tags = ["go", "golang"]
Title = "Limiting Number of Goroutine"
+++

Several days ago, I'm scraping some data from a public website. It's simple enough to do in Go, just concurrently fetch the pages via `goroutine`, parse it with `goquery`, then save it to database. Unfortunately, the scraping is failed because the website detects that there are too many concurrent requests from my IP.

To work around this, I limit the number of goroutines to max 10 at a time. Fortunately, this is really easy thanks to channels and `sync` package :

```go
package main

import (
"sync"
)

func main() {
// urls is list of URL that will be downloaded
urls := []string{
"http://example-site.com/about",
"http://example-site.com/contact",
...
}

// waitGroup is used to make sure app doesn't finish prematurely
// until all goroutines finished
waitGroup := sync.WaitGroup{}
waitGroup.Add(len(urls))

// guard is a channel that used to make sure that only N=10
// goroutines will run at a time
guard := make(chan struct{}, 10)

for _, url := range urls {
// as we loop through URLs, first we put an empty struct to channel guard.
// If the channel is still empty, the process will continue to the next line.
// Else, the process will be blocked until there are rooms in the channel to put the empty struct.
guard <- struct{}{}

go func(url string) {
// when this goroutine finished, make sure to :
// - mark the waitGroup for this goroutine as finished; and
// - release the guard, so the next goroutine can be run.
defer func() {
waitGroup.Done()
<-guard
}()

// download and process the URL
scrapWebPage(url)
}(url)
}

// wait until all goroutine finished
waitGroup.Wait()
}
```

As you can see, the code itself is really simple. For `guard`, I use channel of empty struct instead of other types like boolean or integer. This is because empty structs occupies zero bytes of storage, which means we can put as many guard as we want without worrying about memory usage. For more details about empty structs, do check out the [article](https://dave.cheney.net/2014/03/25/the-empty-struct) by Dave Cheney which thoroughly explains about empty structs.
