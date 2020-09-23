+++
Author = "Radhi Fadlillah"
CreateTime = 2019-07-29T14:18:31+07:00
Tags = ["tutorial", "linux", "qt"]
Title = "Build Static Qt 5.13.0 for Linux"
+++

While working on [Qamel][1], I want it to support compiling static app for Linux and Windows. When targetting Windows, this is simple enough thanks to project like [MXE][2] and [MSYS2][3] which already provided static Qt libraries. However, when targeting Linux platform, there are no choice except building static Qt libraries by ourself.

In this tutorial, I will use Ubuntu 16.04 and the static Qt will be build into `/home/radhi/Qt.5.13.0.Static`.

First we need to install the required dependencies. There are two type of dependencies: the dependencies that used for Qt's [development][4] and the dependencies that used for static [build][5].

```
sudo apt-get update
sudo apt-get install build-essential libgl1-mesa-dev \
    libfontconfig1-dev libfreetype6-dev libx11-dev libxext-dev \
    libxfixes-dev libxi-dev libxrender-dev libxcb1-dev \
    libx11-xcb-dev libxcb-glx0-dev libxkbcommon-dev \
    libxkbcommon-x11-dev '^libxcb.*-dev'
```

Next download the Qt's [source code][6]. If you want to download the old version, you can download it via its [repositories][7]. After download finished, extract it to wherever you want.

Next, open terminal inside the directory where you extract the source code. Here we will run `./configure` to specify that we want to build static libraries. There are many parameters that can be changed which can be seen in [documentation][8] or by running `./configure -h`. In my case, I do it like this :

```
./configure -static -prefix "/opt/Qt$QT_VERSION" \
    -opensource -confirm-license -release \
    -optimize-size -strip -fontconfig \
    -qt-zlib -qt-libjpeg -qt-libpng -qt-xcb \
    -qt-pcre -qt-harfbuzz -qt-doubleconversion \
    -nomake tools -nomake examples -nomake tests \
    -no-pch -skip qtwebengine
```

Here's description for the parameters that I used :

- `static` specify that we want to build static version;
- `prefix` is where to put the result;
- `open-source` means we will use the open source license, in this case LGPLv3;
- `confirm-license` tells that we accept the license, therefore we won't be asked again later;
- `release` tells that the output Qt libraries will not support debugging. This is used because in my case the static build will only used for publishing, therefore there is no need to support debugging there;
- `optimize-size` tells that when building our app, we want its size optimized even if it increase the build time for our app;
- `strip` will strips the released binaries of unneeded symbols;
- `fontconfig` tells that our Qt libraries will use fontconfig that provided by system instead of the one that provided by Qt. This is used to avoid ugly error warning about missing fontconfig in some distro;
- `qt-*` tells that our Qt libraries will use the libraries that provided by Qt instead of the one that provided by system;
- `nomake tools` is used because we don't need to build Qt tools (like Qt Creator);
- `nomake examples` because we don't need to build examples;
- `nomake tests` because we don't need to build tests;
- `no-pch` means no precompiled headers, meaning that all the header files (.h) will not be precompiled so we'll get all the benefits from `#ifdef`. This one is used following tutorial from [Retifrav][9];
- `skip qtwebengine` because I don't use it.

Once the configuration process finished, we only need to build it :

```
make -j $(grep -c ^processor /proc/cpuinfo)
```

This might take a long time depending on number of CPU core that available to use. In my case, it took almost 3-4 hours until it finished. Once the build finished, we only need to install it to our specified `prefix` by running :

```
make install
```

Once finished, the static Qt libraries is already built and ready to use.

[1]: https://github.com/RadhiFadlillah/qamel
[2]: https://mxe.cc/
[3]: https://www.msys2.org/
[4]: https://doc.qt.io/qt-5/linux.html#requirements-for-development-host
[5]: https://doc.qt.io/qt-5/linux-requirements.html
[6]: https://www.qt.io/offline-installers
[7]: https://download.qt.io/official_releases/qt/
[8]: https://doc.qt.io/qt-5/configure-options.html
[9]: https://retifrav.github.io/blog/2018/02/17/build-qt-statically/