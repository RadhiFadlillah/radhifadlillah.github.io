+++
Author = "Radhi Fadlillah"
CreateTime = 2019-05-13T07:51:44+07:00
Tags = ["linux", "tutorial"]
Title = "Fix WiFi Doesn't Work After Update in Manjaro"
+++

After big update in Manjaro, the WiFi might not working properly. While this is rare, I've already encountered it in several occasions. To fix this, we just need to restart `dhcpcd` in systemd :

```
sudo systemctl restart dhcpcd
```
