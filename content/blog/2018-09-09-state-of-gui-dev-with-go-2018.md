+++
Author = "Radhi Fadlillah"
CreateTime = 2018-09-11T16:03:40+07:00
Tags = ["golang"]
Title = "State of GUI App Development with Go in 2018"
+++

Several months ago, I've got a job to create a simple desktop app for my company. So, I've been looking for the packages, frameworks or toolkits for developing GUI app in Go. This post is intended as summary and brief analysis for packages that I've tried while working on my job.

The application that I'm asked to make is a POS system which composed of four software :

- One central server.
- One GUI app for cashier.
- One GUI app for warehouse's inventory.
- One GUI app for reports that used by boss.

The GUI app itself is simple, just add a database, create feature for CRUD, add a little websocket for communicating with server, then add a GUI for the user. However, the app must fulfill these requirements :

1. The application must be able to run smoothly on the PC that provided by my company. The PC is [Intel NUC5CPYH][1] with Celeron processor, RAM 2GB and SSD 128GB. So, while it's not really powerful, it should be enough for normal retail use.
2. The application must be able to run or compiled to Windows and Linux. It also must look consistent across platforms. This is because my boss is using Windows 10, while I and the company's PCs that I maintained are using Linux.
3. The application can be styled to match the company's brands and boss's preferences.

### The Tested Packages / Toolkits

At the moment this post written, there are already many packages that can be used for developing GUI app in Go. However, some of them already not maintained anymore, so I exclude them. I also exclude packages like [`go-gtk`][2], [`gotk3`][3], [`govcl`][4] and [`ui`][5], because these packages only support native GUI components, which not themable and my boss thinks it looks old.

With that said, these are the packages or toolkit that I've tried :

- [Electron](#electron)
- [webview](#webview)
- [go-sciter](#go-sciter)
- [therecipe/qt](#therecipe-qt)

### Electron

Since I'm working as a full-stack Software Developer, I've got some knowledge on creating a web app. Therefore, [Electron][6] is the first thing that I've tried for building desktop app. While using Electron, I'm not using Go packages like [`go-astilectron`][7]. Instead, I'm only using it as a viewer just like how people at [Wiredcraft][8] did. Basically, the Electron is only for front-end viewer, while Go is used as back-end, and both are communicating through REST API.

**Pros** :

- Since I'm only using Electron as a viewer, I can pretend that I'm making a web app instead a desktop app. This make Electron really easy, because it doesn't require any additional knowledge from me.
- I get all benefits of creating web app in desktop, like fast GUI prototyping, easy styling, huge JS library, consistent look across platforms, etc.
- It's open source and distributed under permissive license (MIT).

**Cons** :

- Electron is a full-fledged web browser, which make it really, really heavy. It uses **lot** of memories, even when it's only running and not used. In my development PC, it uses around 300 MB on stand by. It also feels quite sluggish on the company's PC, even though the app itself is simple and doesn't do any heavy work.
- I ended up making a lot of desktop components like tooltip, dialog, etc on my own. It's partly my fault though, because there are actually many libraries for that. However, all of those libraries require bundler like `webpack` which somehow or another I could never understand how to use it. This is also why I prefer Vue.js instead of React.
- Because the front-end communicating with my Go server through REST API, I sometimes ended up with two sets of code in JS and Go that handle one same action. This is fine for web app, because the front-end and back-end is located in two different place. However, for desktop app, this issue is quite annoying for me, especially because I have to work on both.

> Electron is great and easy to use, however it's too heavy and sluggish for my case. While I'm on it, thanks to the third cons, I realize that using REST API is not exactly suitable for creating desktop app. However, since I'm planning to use Go as the base language, as far as I know there are no choice except to use REST API.

### Webview

[webview][9] is a _"tiny cross-platform webview library for C/C++/Golang to build modern cross-platform GUIs"_. It's used as viewer for the web app that served by Go server, while supposed to be tinier and lighter than Electron. This is why I choose this package as the second package that I've tried.

**Pros** :

- It's open source and distributed under permissive license (MIT).
- Like Electron, I get all benefits of creating web app in desktop.
- It's easy to use, simply run [`Open`][10] to show the URL that you want.

**Cons** :

- It's not exactly lightweight. For example, in my Manjaro Linux, the `WebKitWebProcess` that used by Webview uses around 130 MB on stand by.
- It's actually render the page slower than Electron, and in some case it will render incorrectly, e.g. the text is jumped or there are some background without color. To be fair, it's not exactly Webview's fault. Instead, this is the fault of WebKit that used by Webview.
- In Windows, it uses MSHTML (IE10/11). This is quite an annoyance for me because some JS library that I use (e.g. [Vue.js][11] and [axios][12]) has some problems or requires additional polyfill to work properly.
- Cons in Electron also applied here.

> To be fair, the library itself is indeed tiny. However, the web viewer is actually quite heavy, because it uses Cocoa or WebKit on macOS, gtk-webkit2 on Linux and MSHTML (IE10/11) on Windows. And since on most case Electron (or rather Chrome) render the page faster and better than WebKit or MSHOME, I think I still prefer Electron instead of this.

### go-sciter

[`go-sciter`][13] is Golang package that provide bindings for [Sciter][14]. Sciter itself is an HTML/CSS/scripting engine designed to render modern desktop application UI. Sciter distributed as a single library with small size (only 4-8 MB), and doesn't have any additional dependencies. It works on Microsoft Windows, Apple OS X and Linux/GTK. For rendering the view, Sciter uses Direct2D GPU accelerated graphics on modern Windows versions and GDI+ on XP. On macOS, it uses standard CoreGraphics primitives, while in Linux it uses Cairo. 

Even though Sciter uses HTML, CSS and JS-like scripts, developing Sciter's app is actually [very different][15] compared to developing web app. It's not really a bad thing per se, however If you (just like me) think that migrating from web app to Sciter is only a matter of copy-pasting or reusing code, you will come to a bad surprise. Sciter is more comparable to QtQuick, where QtQuick is only using one mark-up language, while Sciter uses three.

Unlike other GUI toolkit that I've tried here, Sciter is proprietary and commercial library with free tier available. In free tier, we can use the provided library however we want, without any access to the Sciter's source code. If you want to look at the source code, you must pay for one of the available [licenses][16].

**Pros** :

- It has permissive license.
- It's really fast and light, especially compared to Electron and Webview. The RAM usages also small, around 50 MB on stand by. It's because Sciter is not a full-blown browser unlike the other two.
- Although it's not really popular, Sciter has been used by large companies like Symantec, ESET and Avast. I've also seen some Chinese CCTV system that use Sciter for its GUI.
- Even though it's proprietary, it has an active [community][17] and its [creator][18] is really active on answering the questions.

**Cons** :

- Sciter use JS-like script language called TIScript. The good thing, it's really [similar][19] to JavaScript, which make it feels familiar. The bad thing, sometimes I forget that I'm not working on JavaScript project. This is quite annoying, because sometimes I already typed the JS keyword, only to find out that the keyword is not supported. The most common thing that I mistook are `console.log`, sorting and string interpolation.
- The community is small, which make Googling the problem sometimes doesn't give the solution.
- The documentation is not really good and the tutorial is quite scarce. It's true for both: the binding and the Sciter itself. The [examples][20] for binding also quite basic and doesn't really represent a real world app.
- Because Sciter doesn't use JS, most library that I'm used to use (e.g. chart, dialog, animation) are not available. This is understandable though, because Sciter is not a browser. The problem is (AFAIK) there are no list of components or libraries that ready to use in Sciter. I also unable to find how to create your own component.
- As it is right now, Sciter still doesn't support CSS grid (flexbox is [supported][21] though). Unfortunately, I've been really spoiled by grid. Grid is awesome because it is 2-dimensional system, meaning it can handle both columns and rows. This make designing layout really easy and clean, unlike the old time where we stuck with floats or tables. Sure, flexbox can do it as well. However, flexbox is only 1-dimensional, so it's not as clean as grid.

> Sciter is great and I'm quite surprised that it's not really popular. It's fast and light. The creator is really active and dedicated on his craft. The license is permissive as well. Unfortunately, because of the documentation and small community, it might be hard to find the resource for learning Sciter. However, if you've got the time to learn and digging for more information, it might be good to learn about Sciter, especially considering how light, fast and permissive it is.

### therecipe/qt

[`therecipe/qt`][22] is Qt binding for Go with support for Windows, macOS and Linux. [Qt][23] itself is a cross-platform application framework that is used for developing application software that can be run on various software and hardware platforms with little or no change in the underlying codebase. It has been used by many developer around the world and should be familiar to Linux user, because some of the most popular apps in Linux is built using Qt, e.g. [KDE][24], [LXQt][25], [Digikam][26], [QBitTorrent][27], etc.

Qt provides two way for developing GUI app: using Widgets or Quick. [QtWidgets][28] provides a library of UI elements which allow you to create classic desktop-style user interfaces, while [QtQuick][29] is a library providing types and functionalities for building modern, fluid, animated UIs. With that said, I choose QtQuick because it matches the app requirements.

In QtQuick, the view is built using QML language. [QML][30] is a declarative language that allows user interfaces to be described in terms of their visual components and how they interact and relate with one another. It is a highly readable language that was designed to enable components to be interconnected in a dynamic manner, and it allows components to be easily reused and customized within a user interface.

**Pros** :

- Both Qt and the binding are open source.
- Because Qt is an old library, there are huge communities around it. This makes the resources for learning it are easy to find.
- The Qt's [documentation][31] is really great. It covers almost everything that I need, and it provides many examples that covers almost every Qt's use case.
- The binding's documentation is also good. The project's [wiki][32] covers almost everything that I need to know, from installation, cross-compilation, and limitation of this binding. The [examples][33] are excellent, because most of example in Qt that uses C++ has been ported to Go. If those examples are too hard for you, the author also provides [basic examples][34] that simpler and easier to learn.
- QtQuick only uses one mark-up language (QML) for declaring layout, styling and putting action on the view. This is nice because I only have to use one language instead of three, especially since I'm working alone.
- QML is really fun and easy to use. It [supports][35] JavaScript expressions for controlling the action in view, which make it feels familiar. The JavaScript here is the standard JS, not JS-like as in Sciter. Besides that, Qt already provides many [components][36] that ready to use and clearly documented. You can also easily [create][37] a new component depending on your needs.
- QML supports [grid][38] that similar and might be more powerful than CSS grid.
- The app that built using this binding + QtQuick is fast and light, especially compared to Electron. For my QML app, the RAM usage is still reasonable, around 100 MB on stand by.
- The binding provides easy way to cross-compile by using [Docker][39] images.

**Cons** :

- The license for Qt and the binding are not really permissive. For the free tier, Qt uses LGPL license (except some modules, like QtCharts, QtDataVisualization and QtVirtualKeyboard that uses GPLv3). This is not exactly a problem, because most of the time you won't need to modify the Qt library, and you will only use it through dynamic linking. The problem is, the binding uses LGPL license as well. LGPL license insists that end user must be able to recombine or relink the application with a modified or different version of the LGPL library, to produce a modified executable. However, as we know, Go uses static linking for all packages that used in an app. Therefore, if you use this binding for your app, you can't make your app proprietary. Do note the GPL limitation is only affecting you if you release the app to public, and only **if they ask** you for it. This is not exactly a problem for me, because according to my contract the app and the source code that I've created for this project is the right of my boss as the company's owner. However, your situations may vary. For more details, do check out the binding's [wiki][40].
- The compiling process is slow, which take around 30 seconds up to 1 minute. This is especially noticable since standard Go code compiles really, really fast. However, the wiki already mentioned several tips to make compile time faster. If you are only using QtQuick, most of the development time will be spent on creating and styling view using QML language. In this case, you should use tool like [`qml-livereload`][41] or [`liveqml`][42].
- There is a weird [bug][43] in QtQuick that make the window is flickering or not rendered correctly after resized. There is a workaround though, by making sure that the window **always** has one component that has active focus.
- QML doesn't have any keyword for `padding`, which kind of throwing me off because I'm already used to it in web app development.
- This is not exactly a major issue, however I'm mildly annoyed with the name of this binding. The actual name for this binding is simply `qt`, which make it kind of weird to say `qt is binding for Qt`. That's why I'm often call this binding `therecipe/qt` inside only `qt`. There is a plan to [rename][44] this binding, however the owner still haven't decide which name to use.

> This binding + QtQuick is really great. It combines almost all of the good thing from the other packages or toolkit that I've tried. The QML make styling and creating a modern UI really and flexible. QML also provides many components that ready to use and easy to extend. Qt has a huge community, which make Googling the problem is easy. Not to mention the great documentation that Qt and this binding have. Seriously, if you are planning to create open source app, or if your situation can allow you to accept the limitation of LGPL license, there are no reason to not use this binding.

### Conclusions

- When possible, use `therecipe/qt` + QtQuick. Except for the license, I don't think there are any reason to not use it. This is what I ended up using for the company's app.
- If you have no time, chased by deadline, and don't have any time to test other tools, use Electron. However, do note that Electron is really heavy on resources, so I'm only using this as the last or temporary choice. For the company's app, I've used Electron for the first three months, then I replace it with Qt.
- Sciter is interesting because it's faster and lighter than the other, not to mention it has permissive license unlike Qt and `therecipe/qt`. However, because I was busy and the docs are not really good, I haven't use it very much and only tested the demos. If you've got the time to learn, experiment, digging information and asking in forum, you should try it.
- I can't recommend `webview` because sometimes it's failed to render my view correctly.

[1]: https://www.amazon.com/Intel-NUC5CPYH-Graphics-2-5-Inch-BOXNUC5CPYH/dp/B00XPVRR5M/ref=sr_1_1?s=electronics&ie=UTF8&qid=1536487840&sr=1-1&keywords=Intel+NUC5CPYH
[2]: https://github.com/mattn/go-gtk
[3]: https://github.com/gotk3/gotk3
[4]: https://github.com/ying32/govcl
[5]: https://github.com/andlabs/ui
[6]: https://electronjs.org/
[7]: https://github.com/asticode/go-astilectron
[8]: https://wiredcraft.com/blog/high-security-electron-js-application
[9]: https://github.com/zserge/webview
[10]: https://godoc.org/github.com/zserge/webview#Open
[11]: https://vuejs.org/
[12]: https://github.com/axios/axios
[13]: https://github.com/sciter-sdk/go-sciter
[14]: https://sciter.com/
[15]: https://sciter.com/developers/for-web-programmers/
[16]: https://sciter.com/prices/
[17]: https://sciter.com/forums/
[18]: https://sciter.com/forums/users/andrew/
[19]: https://sciter.com/docs/js-dart-tis.html
[20]: https://github.com/sciter-sdk/go-sciter/tree/master/examples
[21]: https://sciter.com/docs/flex-flow/flex-layout.htm
[22]: https://github.com/therecipe/qt
[23]: https://www.qt.io/
[24]: https://www.kde.org/
[25]: https://lxqt.org/
[26]: https://www.digikam.org/
[27]: https://www.qbittorrent.org/
[28]: http://doc.qt.io/qt-5/qtwidgets-index.html
[29]: http://doc.qt.io/qt-5/qtquick-index.html
[30]: http://doc.qt.io/qt-5/qmlapplications.html
[31]: http://doc.qt.io/qt-5/
[32]: https://github.com/therecipe/qt/wiki/
[33]: https://github.com/therecipe/qt/tree/master/internal/examples
[34]: https://github.com/therecipe/examples
[35]: http://doc.qt.io/qt-5/qtqml-javascript-expressions.html
[36]: http://doc.qt.io/qt-5/qmltypes.html
[37]: http://doc.qt.io/qt-5/qtqml-syntax-objectattributes.html
[38]: http://doc.qt.io/qt-5/qml-qtquick-layouts-gridlayout.html
[39]: https://hub.docker.com/r/therecipe/qt/
[40]: https://github.com/therecipe/qt/wiki/FAQ#licensing-1
[41]: https://github.com/penk/qml-livereload
[42]: https://github.com/RadhiFadlillah/liveqml
[43]: https://bugreports.qt.io/browse/QTBUG-46074
[44]: https://github.com/therecipe/qt/issues/382