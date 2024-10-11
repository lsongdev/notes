---
layout: default
title: Router
parent: Network
---

## Router 路由器

路由器是一种限制了特定用途的计算机设备，它的主要用途是为了连接网络。一般来说具备以下功能：

* [PPPoE 拨号服务](./pppoe)
* [DHCP 动态主机配置协议](./dhcp)
* [DNS 域名解析服务](./dns)
* [NAT 网络地址转换](./nat)
* [Firewall 防火墙](./firewall)
* [VPN 虚拟专用网络](./vpn)

### 交换机

### 软路由

软路由是使用通用计算机实现网络路由器功能，一般来说软路由的优势在于：

* 性能上限高
* 可定制性强
* 可扩展性强
* 某些情况下有价格优势

软路由一般来说 NIC 接口都是比较少的，而且基本没有提供 Wi-Fi 功能，我们需要连接交换机来扩展更多的接口出来，Switch 交换机

* Ubnt Switch USW 24 Port
* TP-LINK 24
* TP-LINK 8 PoE * 2

KEY	VALUE
----   -----
CPU	J900
RAM	4GB
DISK	64GB
NIC	4 * 1G

J1900 是 x86 架构的主机，低功耗、无风扇设计，比较适合长时间运行，性能够用价格便宜。

这个 Gateway 我没有使用 OpenWRT 和 iKuai 爱快以及 pfSence 之类的系统，理由如下：

* iKuai 爱快虽然有着不错的 UI 界面以及多线接入和流控功能，但是系统的开放程度不高，我不能控制特定的端口背后运行的服务，比如我想在网关上跑 Nginx 和 HAProxy 之类的就比较困难。
* pfSense 是很专业的 Firewall 防火墙系统，功能非常强大，但是同样有上面的类似的问题，可定制能力有限。
* OpenWRT 非常接近我的需求，事实上我在另外一个网络中也一直在用，只是在 J1900 上使用它有点浪费了。