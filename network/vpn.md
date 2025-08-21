---
layout: default
title: VPN
parent: Network
---

# VPN

Open Source VPN options

* [Amnezia VPN](https://github.com/amnezia-vpn) (OpenVPN & WireGuard protocols) - Windows, MacOS, iOS, Android, Linux (no ARM support)
* [boringproxy](https://github.com/boringproxy/boringproxy) (in-house developed "NameDrop" protocol) - Windows, MacOS, Linux, FreeBSD, OpenBSD
* [boringtun](https://github.com/cloudflare/boringtun) (WireGuard protocol) - MacOS, Linux _(mobile clients [not open source](https://cloudflarewarp.com/))_
* [Brook](https://github.com/txthinking/brook) (in-house developed "Brook" protocol as well as WebSocket Secure, SOCKS5, and QUIC protocols) - Windows, MacOS, Linux, OpenWrt _(mobile clients [not open source](https://github.com/txthinking/brook/issues/32#issuecomment-305452096))_
* [Chisel](https://github.com/jpillora/chisel) (SSH protocol) - Windows, MacOS, Linux
* [cjdns](https://github.com/cjdelisle/cjdns) (in-house developed "CryptoAuth" protocol) - Windows, MacOS, Linux, FreeBSD, NetBSD
* [Cloak](https://github.com/cbeuw/Cloak) (OpenVPN & Shadowsocks protocols) - Windows, MacOS, Linux
* [Crowbar](https://github.com/q3k/crowbar) (OpenVPN + SSH protocols) - Windows, MacOS, Linux, FreeBSD, OpenBSD
* [DSVPN](https://github.com/jedisct1/dsvpn) (TCP) - no binaries; can compile for MacOS, Linux, OpenBSD, DragonFly BSD, FreeBSD, NetBSD
* [EdgeVPN](https://github.com/mudler/edgevpn) (TCP) - Windows, MacOS, Linux, FreeBSD
* [EdgeVPNio (evio)](https://github.com/EdgeVPNio/evio) (WebRTC) - only binary is Debian/Ubuntu deb repo; can compile for Linux
* [eduVPN](https://github.com/eduvpn) (OpenVPN protocol) - Windows, MacOS, iOS, Android, Linux
* [fastd](https://github.com/NeoRaider/fastd) (UDP) - MacOS, Linux, FreeBSD, OpenBSD _(Android exists in code but unmaintained since 2020)_
* [Firewalla](https://github.com/firewalla/firewalla) (OpenVPN, WireGuard, AnyConnect SSL) - hardware-specific binary images; mobile clients not open source
* [Firezone](https://github.com/firezone/firezone) (WireGuard) - no binaries; can compile for Linux _(other platforms on their [roadmap](https://www.firezone.dev/product/roadmap))_
* [Global Socket](https://github.com/hackerschoice/gsocket) (TCP) - only binary is Debian/Ubuntu deb file; can compile for MacOS, Linux, FreeBSD, Solaris
* [GNUnet](https://git.gnunet.org/) (TCP) - Linux
* [GreenTunnel](https://github.com/SadeghHayeri/GreenTunnel) (SOCKS5 protocol) - Windows, MacOS, iOS
* [HevSocks5Tunnel](https://github.com/heiher/hev-socks5-tunnel) (SOCKS5 protocol) - can compile for MacOS, Android, iOS, Linux, FreeBSD
* [Husarnet](https://github.com/husarnet/husarnet) (UDP with TCP fallback) - Windows and Linux, MacOS in alpha _(website says "Android coming soon")_
* [Hyprspace](https://github.com/hyprspace/hyprspace) (TCP protocol) - Windows, MacOS, Linux _(discontinued)_
* [Hysteria](https://github.com/HyNetwork/hysteria) (in-house protocol based on QUIC) - Windows, MacOS, Linux
* [i2pd](https://github.com/PurpleI2P/i2pd) (Invisible Internet Protocol [I2P](https://i2pgit.org/i2p-hackers/i2p.i2p)) - Windows, MacOS, iOS, Android, Linux, FreeBSD _(designed to access darkweb services and p2p applications; can be used to proxy regular Internet but they recommend Tor for that)_
* [Iodine](https://github.com/yarrick/iodine) (DNS protocol) - Linux, FreeBSD, OpenBSD, NetBSD _(also Windows and MacOS with third-party drivers)_
* [IVPN](https://github.com/ivpn) (WireGuard and OpenVPN protocols) - Windows, MacOS, iOS, Android, Linux _(commercial service)_
* [Ki4a](https://github.com/Belval/ki4a) (SSH protocol) - Android
* [Kilo](https://github.com/squat/kilo) (WireGuard protocol) - Linux _(requires Kubernetes)_
* [kytan](https://github.com/changlan/kytan) (UDP) - MacOS (client only), Linux
* [Lantern](https://github.com/getlantern/lantern) (UDP) - Windows, MacOS, iOS, Android, Linux _(switched to closed source; see archive directory; neither Lantern Free nor Lantern Pro support customized server location)_
* [Lightway Laser](https://github.com/expressvpn/lightway-laser) (in-house developed "Lightway Core" protocol) - Linux
* [Lokinet](https://github.com/oxen-io/lokinet) (in-house developed "LLARP" protocol) - Windows, MacOS, Linux ([Android](https://github.com/oxen-io/lokinet-flutter-app/tree/dev/android) & [iOS](https://github.com/oxen-io/lokinet-flutter-app/tree/dev/ios) builds are [broken](https://github.com/oxen-io/lokinet-flutter-app/issues/19#issuecomment-1685279629))
* [MASQ](https://github.com/MASQ-Project/Node) (Gossip protocol) - Windows, MacOS, Linux _(CI builds; freemium service)_
* [Meshbird](https://github.com/meshbird/meshbird) (in-house developed "meshbird" protocol) - MacOS, Linux (no ARM support)
* [Mysterium](https://github.com/mysteriumnetwork/node) (WireGuard protocol) - Windows, MacOS, Android, Linux _(commercial service)_
* [Mullvad](https://github.com/mullvad/mullvadvpn-app) (OpenVPN & WireGuard protocols) - Windows, MacOS, iOS, Android, Linux _(commercial service)_
* [n2n](https://github.com/ntop/n2n) (in-house developed "n2n" protocol) - Linux; can compile for Windows, MacOS, Android
* [Nebula](https://github.com/DefinedNet/nebula) / [Mobile Nebula](https://github.com/DefinedNet/mobile_nebula) (Noise protocol) - Windows, MacOS, iOS, Android, Linux, FreeBSD _(full tunnel [not supported](https://github.com/slackhq/nebula/issues/307#issuecomment-1194547903))_
* [Netbird](https://github.com/netbirdio/netbird) (WireGuard protocol) - Windows, MacOS, iOS, Android, Linux _(freemium service)_
* [Netmaker](https://github.com/gravitl/netmaker) (WireGuard protocol) - Windows, MacOS, Linux, FreeBSD _(freemium service; they say an [Android app is in development](https://github.com/gravitl/netmaker/discussions/631#discussioncomment-7280168))_
* [OmniEdge](https://github.com/omniedgeio/omniedge) (n2n protocol) - MacOS, Linux, FreeBSD, OpenWrt; can compile for Windows, iOS, Android, Synology _(discontinued commercial service)_
* [OpenConnect](https://gitlab.com/openconnect/openconnect) (SSL protocol) - Windows, MacOS, Linux, FreeBSD, OpenBSD, NetBSD, DragonFly BSD, Solaris
* [openfortivpn](https://github.com/adrienverge/openfortivpn) (PPP + SSL protocols) - MacOS, Linux _(compatible with Fortinet VPNs)_
* [OpenGNB](https://github.com/gnbdev/opengnb) (in-house developed "gnb" protocol) - MacOS, Linux, FreeBSD, OpenBSD, OpenWrt
* [OpenVPN](https://github.com/OpenVPN/openvpn) (in-house developed "OpenVPN" protocol) - Windows, MacOS, iOS, Android, Linux, ChromeOS _(via freemium [OpenVPN Connect](https://openvpn.net/client/))_
* [OpenZiti](https://github.com/openziti) (in-house developed "ziti" protocol) - can compile embedded library and edge clients for Windows, MacOS, iOS, Android, Linux _(binaries available from freemium service)_
* [Orchid](https://github.com/OrchidTechnologies/orchid) (Ethereum protocol) - MacOS, iOS, Android _(commercial service)_
* [Outline](https://github.com/Jigsaw-Code/outline-server) (Shadowsocks protocol) - Windows, MacOS, iOS, Android, Linux (no ARM support), ChromeOS
* [PairMesh](https://github.com/pairmesh/pairmesh) (Noise protocol) - Windows, MacOS, Linux
* [Pomerium](https://github.com/pomerium/pomerium) (gRPC protocol) - any platform that runs [Docker](https://www.docker.com/) _(commercial service; management UI not open source)_
* [PowerTunnel](https://github.com/krlvm/PowerTunnel) (TCP and [UDT](https://en.wikipedia.org/wiki/UDP-based_Data_Transfer_Protocol) protocols) - Windows, MacOS, Linux, Android
* [PQ-WG](https://github.com/qkniep/pqwg-rust) (WireGuard + modified post-quantum protocols) - can compile for Linux
* [Pritunl Zero](https://github.com/pritunl/pritunl-zero) (SSH protocol) - Linux
* [Private Internet Access](https://github.com/pia-foss) (Wireguard and OpenVPN protocols) - Windows, MacOS, iOS, Android, Linux, ChromeOS, browser extensions _(commercial service)_
* [ProtonVPN](https://github.com/ProtonVPN) (Wireguard and OpenVPN protocols) - Windows, MacOS, iOS, Android, Linux, ChromeOS, browser extensions _(commercial service)_
* [Psiphon](https://github.com/Psiphon-Inc) (SSH protocol) - Windows, iOS, Android _(commercial service; MacOS with Apple silicon client not open source)_
* [RadVPN](https://github.com/mehrdadrad/radvpn) (UDP protocol) - can compile for Linux
* [Rosenpass](https://github.com/rosenpass/rosenpass) (Wireguard protocol) - MacOS, Linux
* [rtun](https://github.com/snsinfu/reverse-tunnel) (TCP and UDP protocols) - Windows, MacOS, Linux, FreeBSD
* [Simple-VPN](https://github.com/skx/simple-vpn) (Websocket protocol) - Linux
* [SoftEther](https://github.com/SoftEtherVPN/SoftEtherVPN/) (SSL, OpenVPN, IPsec, L2TP, MS-SSTP, L2TPv3, and EtherIP protocols) - Windows, MacOS, Linux _(WireGuard supported in Developer Edition only)_
* [sshuttle](https://github.com/sshuttle/sshuttle) (SSH protocol) - MacOS, Linux, FreeBSD, OpenBSD
* [strongSwan](https://github.com/strongswan/strongswan) (IKEv2/IPSec protocol) - MacOS, Linux, FreeBSD _(can be compiled for [Android](https://github.com/strongswan/strongswan/tree/master/src/frontends/android))_
* [Tailscale](https://github.com/tailscale) / [Headscale](https://github.com/juanfont/headscale) (WireGuard protocol) - Windows, MacOS, iOS, Android, Linux _(freemium service; mobile clients not open source)_
* [Tinc](https://github.com/gsliepen/tinc) (in-house developed "tinc" protocol) - Windows, Linux _(MacOS, iOS, and Android supported via closed source third-parties)_
* [Tor](https://github.com/torproject) (TCP protocol) - _Tor Browser available on Windows, MacOS, Android, and Linux_
* [TunProxy](https://github.com/raise-isayan/TunProxy) by raise-isayan (TCP protocol) - can build for Android
* [V2Ray](https://github.com/v2fly/v2ray-core) (in-house developed "mKCP", "Mux.Cool", and "VMess" protocols) - _"V2Ray itself is just a kernel. The GUI client of V2Ray is mostly a shell called V2Ray kernel, similar to the relationship between the Linux kernel and the Linux operating system. But many clients of Shadowsocks are re-implemented [to support] the [V2Ray] protocol[s] by the [V2Ray] author"_
* [VpnCloud](https://github.com/dswd/vpncloud) (UDP protocol) - Linux
* [VpnHood](https://github.com/vpnhood/VpnHood) (TCP and UDP protocols) - Windows, Android, Linux (server only - Linux client is [not planned](https://github.com/vpnhood/VpnHood/issues/132)) _(website says "the [iOS client](https://github.com/vpnhood/VpnHood/issues/235) still needs to be ready"; QUIC protocol is [on the roadmap](https://github.com/vpnhood/VpnHood/issues/94#issuecomment-1518586820); [VpnHood Server](https://github.com/vpnhood/VpnHood/wiki/How-to-run-VpnHood-Server-on-Linux) is open source but [VpnHood Access Server](https://github.com/vpnhood/VpnHood/wiki/VpnHood-Access-Server) is an experimental freemium service)_
* [vTunnel](https://github.com/net-byte/vTunnel) by net-byte (WebSocket protocol) - Android _(Linux server is [vtun](https://github.com/net-byte/vtun))_
* [Vula](https://codeberg.org/vula/vula) (WireGuard + mDNS + DNS-SD + CSIDH protocols) - Linux
* [weron](https://github.com/pojntfx/weron) (WebRTC protocol) - Windows, MacOS, Linux
* [wesher](https://github.com/costela/wesher) (WireGuard protocol) - can build for Linux
* [WG Tunnel](https://github.com/zaneschepke/wgtunnel) (WireGuard protocol) - can build for Android
* [Windscribe](https://github.com/Windscribe) (WireGuard, OpenVPN, and IKEv2 protocols) - Windows, MacOS, iOS, Android, Linux, ChromeOS, Blackberry, Amazon FireTV, Nvidia Shield, KODI, DD-WRT, Tomato, browser extensions _(commercial service)_
* [WireGuard](https://www.wireguard.com/repositories/) (in-house developed "WireGuard" protocol) - Windows, MacOS, iOS, Android, Linux, OpenBSD, FreeBSD _(see also: [Drago](https://github.com/seashell/drago))_
* [wstunnel](https://github.com/erebe/wstunnel) (WebSocket protocol) - Linux (no ARM support)
* [Yggdrasil](https://github.com/yggdrasil-network/yggdrasil-go) (in-house developed "Yggdrasil" protocol) - Windows, MacOS, Linux, Ubiquiti EdgeRouter, VyOS, FreeBSD, OpenBSD, and OpenWrt
* [ZeroTier](https://github.com/zerotier/ZeroTierOne) (in-house developed "ZeroTier" protocol) - Windows, MacOS, iOS, Android, Linux, Synology _(mobile clients not open source but [library](https://github.com/sbilly/ZeroTierSDK/tree/master/integrations) is; server UI not open source but see [ztncui](https://github.com/key-networks/ztncui) / [ZeroUI](https://github.com/dec0dOS/zero-ui))_