---
layout: default
title: 網絡管理
parent: Linux
nav_order: 2
---

# Linux 網絡管理

+ [dig](dig)
+ [netstat](netstat)
+ [tcpdump](tcpdump)
+ [iptables](iptables)

## ip

**ip** - 显示或操纵路由、设备、策略路由和隧道。
**ip link** - 显示或修改网络设备的属性。
**ip addr** - 显示或修改地址的属性。
**ip route** - 显示或修改路由表。

添加一个新路由。

```shell
ip route add 192.168.1.0/24 via 192.168.2.1
```

删除一个路由。

```shell
ip route del 192.168.1.0/24 via 192.168.2.1
```

## ping

**ping** - 发送 ICMP ECHO_REQUEST 到网络主机。

向192.168.1.1发送ping请求。

```shell
ping 192.168.1.1
```

## ifconfig

**ifconfig** - 显示或配置一个网络接口。

显示eth0的配置。

```shell
ifconfig eth0
```

## traceroute

**traceroute** - 显示数据包到主机的路径。

显示数据包到192.168.1.1的路径。

```shell
traceroute 192.168.1.1
```

## NetworkManager

```shell
~# apt install networkmanager
~# pacman -S networkmanager
```

Enable NetworkManager:

```shell
~# systemctl enable NetworkManager
~# systemctl start NetworkManager
```

Setup

```shell
~$ nmcli
~$ nmtui
```

## WiFi Menu

```shell
apt install netctl
```

```shell
wifi-menu
```
