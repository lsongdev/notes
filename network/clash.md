---
layout: default
title: Clash
parent: Network
---

# Clash

Clash 是一个功能全面的网络流量处理工具。

[Clash Github](https://github.com/Dreamacro/clash)   
[Clash Official Documentation](https://lancellc.gitbook.io/clash)

## 入流量

为了实现流量的规则决策，需要接管流量。根据不同的协议，我们有以下方式：

- [HTTP/HTTPS](./http) 协议
- [Socks5](./socks5) 协议
- Tproxy 协议
- Redir 协议
- TUN 模式

在传统方法中，我们需要确切知道哪些 IP 地址需要代理（黑名单）或不需要代理（白名单）。

- 使用黑名单方法通常需要通过 gfwlist 生成 ipset 地址池。
- 使用白名单方法则是将国内站点加入到 ipset。

白名单允许特定流量直接通行，而其余流量将走代理。
黑名单的缺点是地址列表庞大，查找效率较低，且某些较为冷门的网站可能未被列入，导致被遗漏。
两种方法都需要预先解析准确的 IP 地址，而且需要防止DNS污染，因此成本较高、效率较低。

相比之下，使用 TUN + fake ip 的方式会更简单且高效。

![](https://oss.whaleluo.top/blog/img/202307091530969.png)

`utun` 是 Clash 创建的虚拟网卡。流量进入后，会根据 IP 地址查找相应的域名，并根据规则判断是否使用代理。

```yaml
tun:
  enable: true
  stack: system
  dns-hijack:
    - any:53
    - tcp://any:53
# interface-name: br0
auto-route: true
auto-detect-interface: true
```

为了避免回环问题，我们可以使用 fake ip 作为 DNS 服务。

```yaml
dns:
  enable: true
  ipv6: true
  listen: :1053
  use-hosts: true
  enhanced-mode: fake-ip
  default-nameserver:
    - 223.5.5.5
    - 114.114.114.114
  nameserver:
    - 223.5.5.5
    - 114.114.114.114
#   - tls://1.12.12.12
#   - tls://223.5.5.5:853
#   - tls://dns.rubyfish.cn:853
#   - https://doh.pub/dns-query
#   - https://dns.alidns.com/dns-query
#   - https://119.29.29.29/dns-query
  fake-ip-range: 198.18.0.1/16
  fake-ip-filter:
    - "*.lan"
    - "*.direct"
    - "unifi"
  fallback-filter:
    geoip: true
    geoip-code: CN
    ipcidr:
      - 240.0.0.0/4
    domain:
      - "+.google.com"
      - "+.facebook.com"
      - "+.youtube.com"
      - "+.twitter.com"
  fallback:
    - 8.8.8.8
    - 208.67.222.222
    - tls://8.8.4.4:853
#   - https://1.0.0.1/dns-query
    - https://dns.google/dns-query
    - https://dns.cloudflare.com/dns-query
#   - https://public.dns.iij.jp/dns-query

```

例如，当你访问 google.com 时，首先会请求本地53端口进行 DNS 解析，然后 dnsmasq 将请求转发给 clash 的 DNS。Clash DNS 会从私有地址池（198.18.0.1/16）中返回一个 IP 并保存域名与 IP 的映射关系以备后用。


| DOMAIN     | IP           |
| ----       | ----         |
| google.com | 198.18.0.128 |
| baidu.com  | 198.18.0.6   |

Clash DNS 返回 `198.18.0.1/16` 的私有地址，然后这个流量就会根据路由表找到网卡

```shell
$ ip route
default via 111.196.56.1 dev pppoe-wan
10.8.0.0/24 dev tun0 scope link  src 10.8.0.1
10.10.10.0/24 dev n2n0 scope link  src 10.10.10.1
111.196.56.1 dev pppoe-wan scope link  src 111.196.61.172
172.16.0.0/24 via 10.10.10.2 dev n2n0
192.168.3.0/24 dev wg0 scope link
192.168.6.0/24 dev wg0 scope link
192.168.8.0/24 dev br-lan scope link  src 192.168.8.1
198.18.0.0/16 dev utun scope link  src 198.18.0.1
```

我们可以看到，流量会发送到 utun 这个网络设备上：

```shell
~# ip addr
18: utun: <POINTOPOINT,MULTICAST,NOARP,UP,LOWER_UP> mtu 9000 qdisc mq state UNKNOWN qlen 500
    link/[65534]
    inet 198.18.0.1/16 scope global utun
       valid_lft forever preferred_lft forever
    inet6 fe80::9272:3919:426a:4a04/64 scope link flags 800
       valid_lft forever preferred_lft forever
```

## Rules 规则

接收到流量后，我们可以基于以下模式进行决策：

- Direct (直连)
- Rule (规则)
- Global (全局)

**Direct** 就是所有进来的流量都不经过代理，直接从本地发送和接收。
**Global** 代表所有「进站」流量都走代理。
**Rule** 是基于入站流量的特性，如域名、IP 地址和端口来匹配的。


规则是根据入站的流量特征进行匹配的条件，包括域名、IP 地址、端口 等等。

```yaml
rules:
  - DST-PORT,53,PROXY
  - DST-PORT,22,DIRECT
  - DOMAIN-SUFFIX,api.openai.com
  - RULE-SET,reject,REJECT
```

判断流量是否符合某一规则有很多方法可以用：

+ DST-PORT 判断目的端口
+ RULE-SET 匹配规则集


#### Rule Provider

规则集是将特定规则组合在一个文件中，集中管理。

```yaml
# OpenAI
payload:
  - DOMAIN-SUFFIX,api.openai.com
  - DOMAIN-SUFFIX,cdn.openai.com
  - DOMAIN-SUFFIX,chat.openai.com
  - DOMAIN-SUFFIX,auth0.openai.com
  - DOMAIN-SUFFIX,platform.openai.com
```

有这样的东西就可以允许大家在网络上整理一些规则以订阅

### 出站协议

#### Proxy Provider

和 Rule Provider 类似，Proxy Provider 也是将特定规则集中管理，允许服务提供商发布这些规则供用户订阅。

```yaml
proxy-providers:
  freefq:
    type: http
    path: proxies/freefq.yaml
    url: "https://rawgit.lsong.org/song940/freefq/release/proxies/freefq.yaml"
    interval: 3600
    health-check:
      enable: true
      interval: 600
      url: http://www.gstatic.com/generate_204

```

### Install 安装部署

我这里以 *OpenWRT* 为例，实际上其他系统也差不多

```shell
opkg update # apk update
opkg install kmod-tun # apk add kmod-tun

# see https://github.com/MetaCubeX/mihomo/releases for latest version
wget https://github.com/MetaCubeX/mihomo/releases/download/v1.19.1/mihomo-linux-arm64-v1.19.1.gz
wget https://github.com/MetaCubeX/mihomo/releases/download/v1.19.11/mihomo-linux-arm64-v1.19.11.gz
wget https://github.com/MetaCubeX/mihomo/releases/download/v1.19.26/mihomo-linux-arm64-v1.19.26.gz

gunzip mihomo-linux-arm64-v1.19.1.gz
mv mihomo-linux-arm64-v1.19.1 /usr/bin/clash
chmod +x /usr/bin/clash

wget -O clash-config.zip https://github.com/lsongdev/freefq/archive/refs/heads/master.zip
mv freefq-master /etc/clash

clash -d /etc/clash
```

首次启动会下载 *mmdb* 数据库文件，It'll take a moment，同时观察一下端口情况是否 *port in used*, 确保正常启动。

```shell
clash -d /etc/clash
^C # [Ctrl-C]

ln -s /etc/clash/scripts/init.d/clash-openwrt.sh /etc/init.d/clash
service clash enable
service clash start
```

clash dns listen *1053*, add `127.0.0.1#1053` to *DNS forwardings* and *Size of DNS query cache* set `0` to disable cache.

```patch
# /etc/config/dhcp
config dnsmasq
  ...
  option domainneeded '1'
  option leasefile '/tmp/dhcp.leases'
  option ednspacket_max '1232'
  option nonegcache '1'
  ...
+ list server '127.0.0.1#1053'
+ option cachesize '0'
```

Set ***input*** and ***forwarding*** from `reject` to `allow` in OpenWRT's **Firewall Zone Settings**.

Reboot the Router.

### 使用 OpenWrt 系统日志

OpenWrt 的 `/tmp` 通常是内存盘，持续追加到 `/tmp/log/clash.log` 会挤占可用 RAM。让 `procd` 把 Clash 的标准输出和标准错误交给 `logd`，可使用固定容量的环形缓冲区保留近期日志。 [OpenWrt 日志说明](https://openwrt.org/docs/guide-user/base-system/log.essentials) · [procd 启动脚本](https://openwrt.org/docs/guide-developer/procd-init-scripts)

编辑实际运行的 `/etc/init.d/clash`。保留现有服务选项，在 `start_service()` 的实例配置中直接启动程序并接管输出。

```sh
procd_open_instance
procd_set_param command /usr/bin/clash -d /etc/clash
procd_set_param stdout 1
procd_set_param stderr 1
procd_close_instance
```

移除原命令中写入 `clash.log` 的重定向。若旧脚本的 `stop_service()` 只负责从 PID 文件取 PID 并发送信号，可以交给 `procd` 停止实例。编辑 `/etc/clash/config.yaml`，将日志级别调到 `error` 以减少重复的连接失败警告。 [Mihomo 日志级别](https://wiki.metacubex.one/en/config/general/#log-level)

```yaml
log-level: error
```

验证配置后重启 Clash。远程操作时保留可直连的管理通道，重启期间代理流量可能中断。

```sh
sh -n /etc/init.d/clash
/usr/bin/clash -t -d /etc/clash -f /etc/clash/config.yaml
/etc/init.d/clash restart
logread -e clash | tail -20
pidof clash
netstat -lntp
df -h /tmp
grep MemAvailable /proc/meminfo
```

如日志出现端口占用或 TUN 设备忙，用 `netstat -lntp` 核对实际监听进程，再用 `ubus call service list '{"name":"clash"}'` 核对 procd 管理的实例。若确认旧进程仍在，停止新实例，向已确认的旧 PID 发送 TERM，等待它退出后再启动服务。随后核对代理和 DNS 端口、TUN 接口以及公网管理通道。

旧日志不会随启动方式切换自动释放。如果只需保留故障样本，可先将末尾若干行保存到有权限保护的持久目录，再截断原日志。确认新实例的 stdout 和 stderr 都指向管道，并检查旧文件大小保持为零。

一次 NanoPi R2S 实测中，旧 Clash 日志在内存盘占约 441 MiB，可用内存降至约 12 MiB。清理日志并完成 Clash 进程切换后，`/tmp` 使用率从 92% 降到 2%，可用内存约 777 MiB。公网 SSH、HTTPS 出网及 Tailscale 子网访问均恢复或通过验证。该次操作保持 TUN 的 `gvisor` 设置，未测量不同 TUN 栈的内存差异。
