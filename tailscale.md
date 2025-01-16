---
layout: default
title: Tailscale
---

# Tailscale

```shell
opkg update
opkg install tailscale
opkg install iptables-nft
```

```shell
service tailscale enable
service tailscale restart
```

Open Luci Web interface:

Network --> Interfaces --> Add new interface

+ General settings --> Protocol --> Unmanaged
+ General settings --> Device --> tailscale0
+ Firewall Settings --> tailscale

Network --> Firewall --> Add

+ General settings --> Name --> tailscale
+ General settings --> Input/Output/Forward --> accept
+ General settings --> Masquerading --> ✔
+ General settings --> MSS clamping --> ✔
+ General settings --> Covered networks --> tailscale
+ General settings --> Allow forward to destination zones --> set as you wish
+ General settings --> Allow forward from source zones --> set as you wish
+ Advanced settings --> Covered devices --> tailscale0

```shell
root@bj:~# tailscale up --netfilter-mode=off --advertise-exit-node --advertise-routes=192.168.2.0/24,10.200.2.0/24 --reset
Warning: netfilter=off; configure iptables yourself.

To authenticate, visit:

	https://login.tailscale.com/a/1a336f1e011f47

Success.
```

+ https://github.com/adyanth/openwrt-tailscale-enabler
+ https://www.reddit.com/r/Tailscale/comments/11btcxf/how_to_setup_tailscale_on_openwrt_router/