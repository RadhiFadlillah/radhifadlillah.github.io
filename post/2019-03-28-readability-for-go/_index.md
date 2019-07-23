+++
Title = "Readability for Go"
Excerpt = ""
CreatedAt = "2019-03-28 22:29:10 +0700"
UpdatedAt = "2019-03-28 22:29:10 +0700"
Category = "programming"
Tags = ["go", "golang"]
Author = "Radhi Fadlillah"
+++

> This post is an introduction for `go-readability`, a library for fetching the readable content from a web page. It's released under MIT license and available [here](https://github.com/go-shiori/go-readability).

I've been working on a simple bookmark manager called [Shiori](https://github.com/RadhiFadlillah/shiori) on and off for the last few months. It's main feature is the ability to save the main content of a web page as text which can be easily searched later. To do so, it depends on my own package called [`go-readability`](https://github.com/go-shiori/go-readability).

The problem is, `go-readability` was based on old project by [`ying32`](https://github.com/ying32/readability) which hasn't been updated for almost a year. The parse result from it was good, but still not comparable to result from reader mode in Firefox. So, I decided to rewrite everything to make sure it follows the code in [Readability.js](https://github.com/mozilla/readability) that used by Firefox.

After almost a month, I finished the rewrite. The rewrite was done carefully line by line to make sure it looks and works as similar as possible with Readability.js. This way, hopefully all web page that can be parsed by Readability.js are parse-able by `go-readability` as well. And, if there are new improvements in Readability.js, it should be easy enough to implement it.

As usual, `go-readability` is published in [Github](https://github.com/go-shiori/go-readability) under MIT license. To install this package, assuming you already installed Go, you can just run :

```
go get -u -v github.com/go-shiori/go-readability
```

Then you can use it in your code like this :

```go
package main

import (
	"fmt"
	"log"
	"os"
	"time"

	readability "github.com/go-shiori/go-readability"
)

var (
	urls = []string{
		// this one is article, so it's parse-able
		"https://www.nytimes.com/2019/02/20/climate/climate-national-security-threat.html",
		// while this one is not an article, so readability will fail to parse.
		"https://www.nytimes.com/",
	}
)

func main() {
	for i, url := range urls {
		article, err := readability.FromURL(url, 30*time.Second)
		if err != nil {
			log.Fatalf("failed to parse %s, %v\n", url, err)
		}

		dstTxtFile, _ := os.Create(fmt.Sprintf("text-%02d.txt", i+1))
		defer dstTxtFile.Close()
		dstTxtFile.WriteString(article.TextContent)

		dstHTMLFile, _ := os.Create(fmt.Sprintf("html-%02d.html", i+1))
		defer dstHTMLFile.Close()
		dstHTMLFile.WriteString(article.Content)

		fmt.Printf("URL     : %s\n", url)
		fmt.Printf("Title   : %s\n", article.Title)
		fmt.Printf("Author  : %s\n", article.Byline)
		fmt.Printf("Length  : %d\n", article.Length)
		fmt.Printf("Excerpt : %s\n", article.Excerpt)
		fmt.Printf("SiteName: %s\n", article.SiteName)
		fmt.Printf("Image   : %s\n", article.Image)
		fmt.Printf("Favicon : %s\n", article.Favicon)
		fmt.Printf("Text content saved to \"text-%02d.txt\"\n", i+1)
		fmt.Printf("HTML content saved to \"html-%02d.html\"\n", i+1)
		fmt.Println()
	}
}
```

If you want to use the CLI app, you can install it by running :

```
go get -u -v github.com/go-shiori/go-readability/cmd/...
```

Then you can use it like this :

```
go-readability <url>
```