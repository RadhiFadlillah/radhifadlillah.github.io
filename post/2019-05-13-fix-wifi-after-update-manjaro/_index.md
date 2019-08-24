+++
Title = "Fix WiFi Doesn't Work After Update in Manjaro"
Excerpt = ""
CreatedAt = "2019-05-13 07:51:44 +0700"
UpdatedAt = "2019-05-13 07:51:44 +0700"
Category = "tutorial"
Tags = ["linux", "tutorial"]
Author = "Radhi Fadlillah"
+++

After big update in Manjaro, the WiFi might not working properly. While this is rare, I've already encountered it in several occasions. To fix this, we just need to restart `dhcpcd` in systemd :

```
sudo systemctl restart dhcpcd
```
