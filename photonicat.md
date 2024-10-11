---
title: Photonicat
layout: default
---

# Photonicat - 光影猫

![](https://photonicat.com/assets/device_structure_2-74c3fea8bd3af944599f5a0743d5eaef4728e8b4.png)

Photonicat - 光影猫是一个便携型路由器

![](https://photonicat.com/assets/PCB-Back-3e33adefc3d4e75753c384bf83c20cc62a270ac1.png)

<https://photonicat.com/wiki/Main_Page>

## Flash

+ MiniLoaderAll.bin
+ photonicatwrt-23.04-r5948-b3e5e911f-rockchip-armv8-ariaboard_photonicat-squashfs-sysupgrade.img.gz

![](https://photonicat.com/images/5/55/Burn-usb-port-wiki.png)

- 默认IP地址为：http://172.16.0.1 ，默认密码和默认wifi密码均为：photonicat。

## Apps

删除一些不需要的包

```shell
opkg remove --force-removal-of-dependent-packages \
  samba4-client samba4-server samba4-utils samba4-libs \
  mwan3 luci-app-mwan3 \
  filebrowser luci-app-filebrowser \
  wifischedule luci-app-wifischedule \
  minidlna strongswan udpxy haproxy  \
  aria2 nlbwmon watchcat adblock adbyby dns2socks dnsforwarder dnsproxy \
  luci-app-advanced luci-app-advanced-reboot luci-app-autoreboot luci-app-turboacc \
  luci-app-rclone luci-app-ramfree luci-app-frps luci-app-frpc luci-app-wol luci-app-diskman  \
  luci-app-ttyd luci-app-filetransfer luci-app-socat luci-app-accesscontrol luci-app-upnp \
  luci-app-statistics  luci-app-ntpc  luci-app-commands  luci-app-arpbind luci-app-qos 
```
