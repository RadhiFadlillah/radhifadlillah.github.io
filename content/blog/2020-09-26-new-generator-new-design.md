+++
Author = "Radhi Fadlillah"
CreateTime = 2020-09-26T10:28:59+07:00
Tags = ["golang"]
Title = "New Site Generator, New Site Design"
+++

For the last few weeks I've been working on a new static site generator called [`boom`][1]. I created it to improve my previous static site generator named [`spook`][2].

## About Spook

Several years ago I just got a job and started to receive my own salary. So, like many other programmers, one of the first thing that I bought is a domain for my own name. The next obvious step after buying domain is using it, so I decided to build my own site. At first I planned to use [Hugo][3] because it's famous for its speed and it's built using my favorite language.

Unfortunately, after looking at the documentation I feel a bit intimidated because the documentation was long and confusing (do note that this is back in 2018, nowadays their documentation is really nice). Not to mentions there are many features that I believe I won't need.

So, I decided to create my own static site generator. I thought it will be easy, after all I just want to build a simple blog with one or two static pages and maybe several blog posts. After several weeks, `spook` is created.

In Spook your site content **MUST** be structured like this :

```
.
├── page/
│   ├── page-1/
│   │   └── _index.md
│   └── page-2/
│       ├── _index.md
│       ├── asset-01.png
│       └── asset-02.jpg
├── post/
│   ├── post-1/
│   │   └── _index.md
│   └── post-2/
│       ├── _index.md
│       └── asset.png
├── theme/
│   └── theme-1/
│       ├── list.html
│       ├── page.html
│       └── post.html
└── config.toml
```

- `page` directory contains static pages. Each page must be in its own directory that contains `_index.md` file.
- `post` directory contains blog posts. Each post must be in its own directory that contains `_index.md` file.
- `theme` directory contains themes for site. You can have several themes, each of them has its own dictionary and must have `list.html`, `page.html` and `post.html`.
- `config.toml` is entire site configuration. Here you specify the site's title, the active theme, etc.

As you can see, the site structure is really simple and flat. There are only three templates available :

- `list.html` is template for rendering list of post.
- `page.html` is template for rendering static page.
- `post.html` is template for rendering blog post.

With that said, you won't be able to build any fancy site using this but it works and suitable for my use case back then.

## Boom, the new generator

After around two years, I found several pain points from Spook :

- Spook is more of static blog generator than static site generator. There are only `page` and `post`, and you can't create additional directories. In my case, I want to put portfolio to my website in separate place from the ordinary pages and posts. This is impossible to do in Spook.
- In Spook each post has its own directory whether it has assets or not. Thanks to this, when my site has around twenty posts, the site structure becomes quite long and redundant.
- In Spook you can only have one active theme, and you are limited with only three templates.

With that said, I believe Spook is not suitable anymore for my needs so it's time to use a better static site generator. I was planning to use Hugo, however I'm a bit sad that my time and code in Spook will be wasted. So I decided to improve Spook to fulfill my requirements. Hence how `boom` created.

In Boom your site **MUST** be structured like this :

```
.
├── assets
├── content/
│   └── _index.md
└── themes/
    ├── theme-1
    ├── theme-2
    └── theme-N
```

However, you have total freedom on structuring your assets and content. For example, you can build your site like this :

```
.
├── assets/
│   ├── image-1.jpg		// https://example.com/assets/image-1.jpg
│   ├── image-2.jpg		// https://example.com/assets/image-2.png
│   └── portfolio/
│       └── app-1/
│           ├── screenshot-1.png	// https://example.com/assets/portfolio/app-1/screenshot-1.png
│           └── screenshot-2.png	// https://example.com/assets/portfolio/app-1/screenshot-2.png
├── content/
│   ├── _index.md		// https://example.com
│   ├── directory-1/
│   │   ├── _index.md	// https://example.com/directory-1
│   │   ├── file-1.md	// https://example.com/directory-1/file-1
│   │   └── file-2.md	// https://example.com/directory-1/file-2
│   └── directory-2/
│       ├── _index.md	// https://example.com/directory-2
│       └── file-3.md	// https://example.com/directory-2/file-3
└── themes/
    ├── theme-1
    └── theme-2
```

If in Spook we only allowed three templates, in Boom you can have as many templates as you want. Boom also allows you to set custom theme and template for each markdown file. With that said, I think now Boom fulfills my requirements while still simple enough to use.

## New site design

If you've ever visit this site before, you might remember that it looks like this :

![Screenshot of the old website][asset-1]

I think it's fine. It's readable, mobile-friendly and serve its purpose. If there are any fault, it's too generic and too bright for my eyes. However, since I migrating my site to a new generator, might as well create a new design for it.

Incidentally, while I working on this site, I was fascinated with user interface of the old operating system. One of my favorite is GEOS, a full blown operating system and graphical user interface for the Commodore 64 computer. You could check its screenshots in [Toasty Tech][4], [Guidebook Gallery][5] and [OS News][6], but here is the main screen :

![GEOS screenshot][asset-2]

The hardest part of emulating that design is the font. Pixel bitmap font is not used because it  tends to be poor when scaled or transformed. Meanwhile most of outline font is too modern. In the end I decided to use two fonts, [Chakra Petch][7] for sans-serif and [Share Tech Mono][8] for monospace. Both are vector based so it scales nicely, while still looks a bit retro thanks to its square-ish design.

The end result is as you can see in this post. In case you came from future and the theme is changed again, here is how it looks like :

![Screenshot of the new website][asset-3]

I also decided to use [GoatCounter][9] analytics, an open source web analytics platform. I choose it because it's free, doesn't track users, lightweight and fast. I've set it to public so you can check this site statistics [here][10].

[1]: https://github.com/RadhiFadlillah/boom
[2]: https://github.com/RadhiFadlillah/spook
[3]: https://gohugo.io/
[4]: http://toastytech.com/guis/c64g.html
[5]: https://guidebookgallery.org/screenshots/geosc64
[6]: https://www.osnews.com/story/15223/geos-the-graphical-environment-operating-system/
[7]: https://fonts.google.com/specimen/Chakra+Petch
[8]: https://fonts.google.com/specimen/Share+Tech+Mono
[9]: https://www.goatcounter.com/
[10]: https://radhifadlillah.goatcounter.com/settings
[asset-1]: /assets/2020-09-26-new-design/old-website.png
[asset-2]: /assets/2020-09-26-new-design/geosc64.png
[asset-3]: /assets/2020-09-26-new-design/new-website.png