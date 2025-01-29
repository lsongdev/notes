---
layout: default
title: Tailscale
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

+ https://github.com/adyanth/openwrt-tailscale-enabler
+ https://www.reddit.com/r/Tailscale/comments/11btcxf/how_to_setup_tailscale_on_openwrt_router/
