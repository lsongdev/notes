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

+ [MiniLoaderAll.bin](https://dl.photonicat.com/images/MiniLoaderAll.bin)
+ photonicatwrt-23.04-r5948-b3e5e911f-rockchip-armv8-ariaboard_photonicat-squashfs-sysupgrade.img.gz

![](https://photonicat.com/images/5/55/Burn-usb-port-wiki.png)

- 默认IP地址为：http://172.16.0.1 ，默认密码和默认wifi密码均为：photonicat。


---

opkg update
opkg install kmod-usb-serial kmod-usb-serial-option kmod-usb-serial-wwan \
             kmod-usb-net kmod-usb-net-qmi-wwan \
             uqmi usb-modeswitch luci-proto-qmi


⚠️ 如果是 RM520N-GL 开启了 MBIM 模式，请用 luci-proto-mbim 和 umbim 代替 qmi。

安装完成后，运行以下命令添加模块到 option 驱动支持中（必须）：

echo '0x2c7c 0x0801' > /sys/bus/usb-serial/drivers/option1/new_id

Quectel 的 USB VID 是 0x2c7c，RM520N-GL PID 是 0x0800，若不同请查 lsusb。


在 LuCI 中进入：

网络 > 接口 > 添加新接口

	•	名称：wwan
	•	协议：QMI Cellular
	•	设备选择：一般是 /dev/cdc-wdm0（或用命令 uqmi -d /dev/cdc-wdm0 --get-data-status 验证）

配置如下：
	•	APN：视运营商而定（例如中国移动为 cmnet，电信为 ctnet）
	•	PIN码：留空（如果 SIM 无 PIN）
	•	拨号用户名/密码：一般留空

保存并应用。

或者用 UCI 命令配置：

uci set network.wwan=interface
uci set network.wwan.proto='qmi'
uci set network.wwan.device='/dev/cdc-wdm0'
uci set network.wwan.apn='cmnet'  # 改成你的运营商 APN
uci set network.wwan.auth='none'
uci commit network
/etc/init.d/network restart


设置防火墙和 NAT

uci add firewall zone
uci set firewall.@zone[-1].name='wwan'
uci set firewall.@zone[-1].network='wwan'
uci set firewall.@zone[-1].input='ACCEPT'
uci set firewall.@zone[-1].output='ACCEPT'
uci set firewall.@zone[-1].forward='REJECT'
uci add firewall forwarding
uci set firewall.@forwarding[-1].src='lan'
uci set firewall.@forwarding[-1].dest='wwan'
uci commit firewall
/etc/init.d/firewall restart


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

## Refs

+ https://github.com/openwrtkitty/photonicat-hacks