+++
Title = "Fix USB Printer not Detected in Arch Linux"
Excerpt = "How to fix USB printer that doesn't detected by cups in Arch Linux and its derivatives."
CreatedAt = "2019-04-05 11:08:55 +0700"
UpdatedAt = "2019-04-05 11:08:55 +0700"
Category = "tutorial"
Tags = ["linux", "tutorial"]
Author = "Radhi Fadlillah"
+++

When setting up a printer in Arch and Manjaro, I often found a problem where `cups`  unable to find the printer that connected in USB port. To fix this, we need to allow `cups` to scan and access USB port as root. We can do so by running :

```
sudo chmod og= /usr/lib/cups/backend/usb
```