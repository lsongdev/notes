---
layout: default
title: Tailscale
parent: Network
---

# Tailscale

```shell
opkg update
opkg install iptables ip6tables iptables-nft ip6tables-nft kmod-tun
opkg install tailscale

```

```shell
service tailscale enable
service tailscale restart
```

Open Luci Web interface:

Network --> Firewall --> Add

+ General settings --> Name --> tailscale
+ General settings --> Input/Output/Forward --> accept
+ General settings --> Masquerading --> ✔
+ General settings --> MSS clamping --> ✔
+ General settings --> Covered networks --> tailscale
+ General settings --> Allow forward to destination zones --> set as you wish
+ General settings --> Allow forward from source zones --> set as you wish
+ Advanced settings --> Covered devices --> tailscale0

Network --> Interfaces --> Add new interface

+ General settings --> Protocol --> Unmanaged
+ General settings --> Device --> tailscale0
+ Firewall Settings --> tailscale

```shell
root@bj:~# tailscale up --netfilter-mode=off --advertise-exit-node --advertise-routes=192.168.6.0/24,10.0.0.0/24 --accept-routes # --reset
Warning: netfilter=off; configure iptables yourself.

To authenticate, visit:

	https://login.tailscale.com/a/1a336f1e011f47

Success.
```

status

```shell
root@bj:~# tailscale status
100.86.230.104  bj                   song940@     linux   idle; offers exit node
100.65.146.84   dtting               song940@     linux   idle; offers exit node
100.94.238.92   iphone-15            song940@     iOS     offline
100.121.21.32   lf                   song940@     linux   idle; offers exit node
100.121.109.44  yim-m73              song940@     windows offline
root@bj:~# ping 192.168.3.1
PING 192.168.3.1 (192.168.3.1): 56 data bytes
64 bytes from 192.168.3.1: seq=0 ttl=64 time=207.868 ms
64 bytes from 192.168.3.1: seq=1 ttl=64 time=65.991 ms
64 bytes from 192.168.3.1: seq=2 ttl=64 time=66.369 ms
```

## Troubleshooting

unexpected state: NoState after restart
https://github.com/tailscale/tailscale/issues/15524


## Refs:

+ https://github.com/adyanth/openwrt-tailscale-enabler
+ https://www.reddit.com/r/Tailscale/comments/11btcxf/how_to_setup_tailscale_on_openwrt_router/
