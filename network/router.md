---
layout: default
title: Gateway
parent: Network
---

## Gateway 网关

我需要在 Gateway 网关这个设备中解决上面 Network 章节中所有的问题，也就是说我希望这个叫做「Home Gateway」 的设备接入网络以后，无论是家里的网络访问外部，还是从外面访问家里的网络，都能畅通无阻。

软路由一般来说 NIC 接口都是比较少的，而且基本没有提供 Wi-Fi 功能，我们需要连接交换机来扩展更多的接口出来，Switch 交换机

* Ubnt Switch USW 24 Port
* TP-LINK 24
* TP-LINK 8 PoE * 2

KEY	VALUE
CPU	J900
RAM	4GB
DISK	64GB
NIC	4 * 1G
J1900 是 x86 架构的主机，低功耗、无风扇设计，比较适合长时间运行，性能够用价格便宜。

这个 Gateway 我没有使用 OpenWRT 和 iKuai 爱快以及 pfSence 之类的系统，理由如下：

* iKuai 爱快虽然有着不错的 UI 界面以及多线接入和流控功能，但是系统的开放程度不高，我不能控制特定的端口背后运行的服务，比如我想在网关上跑 Nginx 和 HAProxy 之类的就比较困难。
* pfSense 是很专业的 Firewall 防火墙系统，功能非常强大，但是同样有上面的类似的问题，可定制能力有限。
* OpenWRT 非常接近我的需求，事实上我在另外一个网络中也一直在用，只是在 J1900 上使用它有点浪费了。

最终，我选择安装 debian server 系统，具体安装过程参见「如何从头搭建路由系统」
