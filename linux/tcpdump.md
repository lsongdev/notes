---
layout: default
title: tcpdump
parent: Linux
---

# tcpdump

> tcpdump is a network protocol analyzer.
> 捕获并显示网络流量。

```shell
tcpdump -v
```

在eth0上捕获流量。

```shell
tcpdump -i eth0
```

只捕获与192.168.1.1有关的流量。

```shell
tcpdump -i eth0 'host 192.168.1.1'
```
捕获与192.168.1.1或192.168.3.1有关的流量。

```shell
tcpdump -i eth0 'host 192.168.1.1 or 192.168.3.1'
```

port

```shell
tcpdump -i wlan0 'port = 80'
```