+++
Author = "Radhi Fadlillah"
CreateTime = 2019-04-05T11:08:55+07:00
Description = "Steps to fix USB printer that doesn't detected by cups in Arch Linux and its derivatives."
Tags = ["linux", "tutorial"]
Title = "Fix USB Printer not Detected in Arch Linux"
+++

> This post is summary of this forum [post](https://bbs.archlinux.org/viewtopic.php?id=208821). I write it here again because that forum post is quite hard to reach from Google, so I put it here for my archive.

When setting up a printer in Arch and Manjaro, I often found a problem where `cups`  unable to find the printer that connected in USB port. To fix this, we need to allow `cups` to scan and access USB port as root. We can do so by running :

```
sudo chmod og= /usr/lib/cups/backend/usb
```
