---
title: Photonicat
layout: default
---

# Photonicat - 光影猫

![](https://photonicat.com/assets/device_structure_2-74c3fea8bd3af944599f5a0743d5eaef4728e8b4.png)

Photonicat 一代是基于 Rockchip RK3568 的便携路由器，板卡 ID 为 `ariaboard,photonicat`。本文以一台配备约 4 GiB RAM 和 58.25 GiB eMMC 的设备为例。

![](https://photonicat.com/assets/PCB-Back-3e33adefc3d4e75753c384bf83c20cc62a270ac1.png)

<https://photonicat.com/wiki/Main_Page>

## 升级 ImmortalWrt

本机验证过从 ImmortalWrt 24.10.1 升级到 25.12.2（`r38135-0c4cd0f9920a`，Linux 6.12.103）。下载时选择 `rockchip/armv8` 下的一代 Photonicat SquashFS sysupgrade 镜像。电脑通过有线 LAN 接入，以下命令以设备管理地址 `172.16.0.1` 为例。

```sh
base=https://downloads.immortalwrt.org/releases/25.12.2/targets/rockchip/armv8
img=immortalwrt-25.12.2-rockchip-armv8-ariaboard_photonicat-squashfs-sysupgrade.img.gz
curl -fL --retry 3 -C - -o "$img" "$base/$img"
printf '%s  %s\n' 4238b2bc699b46a007e81da902a7fa6b40d2fb52b9f8c0e0391a19b714f9bc79 "$img" | shasum -a 256 -c -
scp -O "$img" root@172.16.0.1:/tmp/
ssh root@172.16.0.1 "sysupgrade -T /tmp/$img"
```

SHA-256 和 `sysupgrade -T` 均通过后，执行 `ssh root@172.16.0.1 "sysupgrade /tmp/$img"` 可保留受支持的配置并重启。本机用此方式保留了管理地址和 SSH 密钥。使用 `sysupgrade -n` 会清除配置。手动安装的软件包通常需要重装，25.12 使用 `apk`。Rockchip 升级脚本在分区布局变化时可能整盘写入。已有 extroot 时，升级后重新检查分区表、挂载源和实际生效的配置。

```sh
ubus call system board
fdisk -l /dev/mmcblk0
df -h / /overlay
```

- [ImmortalWrt 发布目录](https://downloads.immortalwrt.org/releases/)
- [25.12.2 校验清单](https://downloads.immortalwrt.org/releases/25.12.2/targets/rockchip/armv8/sha256sums)
- [厂商固件目录](https://dl.photonicat.com/images/) · [一代 USB 烧录恢复手册](https://photonicat.com/wiki/Photonicat_%E5%88%B7%E6%9C%BA%E6%93%8D%E4%BD%9C%E6%89%8B%E5%86%8C) · [MiniLoaderAll.bin](https://dl.photonicat.com/images/MiniLoaderAll.bin)

![USB 烧录接口](https://photonicat.com/images/5/55/Burn-usb-port-wiki.png)

## 用 extroot 扩展可写空间

先运行 `fdisk -l /dev/mmcblk0` 和 `df -h / /overlay`。本机原有 16 MiB 启动分区和 300 MiB 系统分区，系统分区内的 F2FS 可写层通过 `/dev/loop0` 挂载。以下扇区号仅适用于本机的 512 字节扇区布局。

1. 用 `fdisk /dev/mmcblk0` 在空闲区创建第三个主分区。本机范围为 745472–122159103。写入前用 `p` 核对前两个分区的起止位置。写入后核对 `/dev/mmcblk0p3` 的起点和大小，必要时用 `partx -a --nr 3 /dev/mmcblk0` 通知内核。
2. 确认第三分区是刚创建的目标后，运行 `mkfs.ext4 -m 1 -L extroot /dev/mmcblk0p3`。挂载到临时目录，用 `tar` 迁移原 `/overlay` 的 `upper` 和 `.fs_state`，并在新分区创建空的 `work` 目录。
3. 用 `block info /dev/mmcblk0p3` 查文件系统 UUID。在 `/etc/config/fstab` 添加启用的挂载项，目标设为 `/overlay`，并将同一份配置复制到新分区的 `upper/etc/config/fstab`。同步并卸载临时挂载点后重启。
4. 检查 `grep " /overlay " /proc/mounts` 和 `df -h / /overlay`。本机确认挂载源为 `/dev/mmcblk0p3`（ext4），可写层容量约 56.7 GiB。 [OpenWrt extroot 操作说明](https://openwrt.org/docs/guide-user/additional-software/extroot_configuration)

## 配置 RM520N-GL 蜂窝拨号

本机的 USB ID 为 `2c7c:0801`。QMI 模式下，控制设备为 `/dev/cdc-wdm0`，数据接口为 `wwan0`，AT 口为 `/dev/ttyUSB2`。先确认这些设备存在。ImmortalWrt 25.12.2 实测已自动绑定 USB 串口和 QMI 驱动。LuCI 显示 *Unsupported protocol type* 时，安装 `luci-proto-qmi` 并刷新页面。若模组配置为 MBIM，则使用对应的 MBIM 驱动、`umbim` 和 `luci-proto-mbim`。

在 LuCI 的「网络 → 接口」创建或编辑 `wwan`，选择 QMI Cellular，设备填 `/dev/cdc-wdm0`，APN 按 SIM 供应商的要求填写。用默认配置的 WAN 防火墙区域承载 `wwan`，检查区域包含该接口并已启用 IPv4 NAT。以下为本机双栈配置，保留已有 APN 和 PIN 设置。

```sh
apk add uqmi luci-proto-qmi picocom
uci set network.wwan=interface
uci set network.wwan.proto=qmi
uci set network.wwan.device=/dev/cdc-wdm0
uci set network.wwan.auth=none
uci set network.wwan.pdptype=ipv4v6
uci set network.wwan.metric=50
uci set network.wwan.timeout=15
uci commit network
ubus call network reload
ifup wwan
```

有线 WAN 通过 DHCP 获得默认网关，蜂窝 IPv4 路由使用较高的 metric。断开 WAN 网线后，运行 `ip -4 route get 1.1.1.1` 确认出接口为 `wwan0`。本机实测有线断开后 LAN SSH 仍可用，路由器可通过蜂窝网络完成 HTTPS 下载。Tailscale 可以经蜂窝连接同一 tailnet 的节点；本机 Dropbear 只监听 LAN 地址，远程 SSH 需要单独配置和验证。

### 处理 PIN_STATUS_FAILED (not_initialized)

复现环境为 `uqmi 2025.07.30~7914da43-r2`，模组固件为 `RM520NGLAAR01A07M4G_01.200.01.200`。换中国电信 SIM 后，AT 接口确认 SIM 已就绪、LTE 已注册；QMI 反复报告 `card_application_state: detected` 和 `pin1_status: not_initialized`，拨号脚本因此中止。QMI 状态差异的根因尚未定位。 [OpenWrt #20949 实机复现](https://github.com/openwrt/openwrt/issues/20949#issuecomment-6845581055)

在路由器上执行以下命令。AT 返回 `+CPIN: READY`，且 QMI 报上述状态时，才考虑应用补丁。

```sh
picocom -q -b 115200 -x 600 -t "$(printf 'AT+CPIN?\r')" /dev/ttyUSB2 </dev/null
uqmi -d /dev/cdc-wdm0 -t 4000 --uim-get-sim-state
logread | grep -E 'PIN_STATUS_FAILED|PIN status failed' | tail
```

以下是设备实际运行的补丁。它仅允许指定接口和控制设备在未配置 PIN、且 AT 明确报告 SIM 就绪时继续拨号。

```diff
--- a/lib/netifd/proto/qmi.sh
+++ b/lib/netifd/proto/qmi.sh
@@ -213,6 +213,15 @@
 			verified)
 				echo "PIN already verified"
 				;;
+		not_initialized)
+			if [ "$interface" != wwan ] || [ "$device" != /dev/cdc-wdm0 ] || [ -n "$pincode" ] ||
+			   ! picocom -q -b 115200 -x 600 -t "$(printf 'AT+CPIN?\r')" /dev/ttyUSB2 </dev/null 2>/dev/null | tr -d '\r' | grep -qx '+CPIN: READY'; then
+				proto_notify_error "$interface" PIN_STATUS_FAILED
+				proto_block_restart "$interface"
+				return 1
+			fi
+			echo "SIM ready according to AT+CPIN?"
+			;;
 			*)
 				echo "PIN status failed (${pin1_status:-sim_not_present})"
 				proto_notify_error "$interface" PIN_STATUS_FAILED
```

在电脑上把补丁代码块保存为 `qmi-pin-ready.patch`，然后执行。命令先在临时目录应用补丁并检查语法，再上传脚本。若脚本已打过补丁或版本上下文不同，先核对差异。

```sh
(
  set -eu
  router=root@172.16.0.1
  stage=$(mktemp -d)
  mkdir -p "$stage/lib/netifd/proto"
  ssh "$router" 'cat /lib/netifd/proto/qmi.sh' > "$stage/lib/netifd/proto/qmi.sh"
  patch -N -p1 -d "$stage" < qmi-pin-ready.patch
  sh -n "$stage/lib/netifd/proto/qmi.sh"
  scp -O "$stage/lib/netifd/proto/qmi.sh" "$router:/tmp/qmi-pin-ready.sh"
  ssh "$router" 'sh -n /tmp/qmi-pin-ready.sh &&
    chmod 0755 /tmp/qmi-pin-ready.sh &&
    mv /tmp/qmi-pin-ready.sh /lib/netifd/proto/qmi.sh &&
    ifdown wwan && ifup wwan'
)
```

等待拨号后检查 `ifstatus wwan`、`ip addr show dev wwan0` 和 `ping -4 -I wwan0 -c 3 1.1.1.1`。本机取得了 IPv4 和 IPv6，蜂窝 IPv4 ping 三次均成功。回退时可按同样的临时目录流程使用 `patch -R -p1`，校验并上传后重启 `wwan`。升级 `uqmi` 或固件后重新检查补丁是否仍适用。

## 配置同名双频 Wi-Fi

板载 QCA9377（SDIO，`ath10k_sdio`）和独立 WCN6855（PCIe，`ath11k_pci`）各负责一个频段。若只看到板载射频，检查 PCIe 是否枚举出 `17cb:1103`，并安装匹配当前固件的驱动和固件包。

```sh
apk add kmod-ath11k-pci ath11k-firmware-wcn6855
modprobe ath11k_pci
iw phy
wifi config
```

按设备路径识别两个 radio。将各自的 AP 加入 `lan`，使用相同 SSID、密码和加密模式。本机配置如下。

| 网卡 | 频段 | 信道 | 模式 |
| --- | --- | --- | --- |
| 板载 QCA9377 | 2.4 GHz | 6 | HT20 |
| 独立 WCN6855 | 5 GHz | 36 | HE80（Wi-Fi 6） |

本机两个 AP 使用 `mobile@lsong.org`。同名 SSID 本身不会产生射频干扰。两个 AP 在不同频段运行，各有独立 BSSID，客户端自行决定选哪个频段。驱动报告独立卡可使用两个并发信道，本机采用两卡各跑一个频段的配置。单卡双频 AP 和实际吞吐尚未测试。

保存后用 `iw dev` 核对两个频率，用 `ubus call hostapd.phy0-ap0 get_status` 和 `ubus call hostapd.phy1-ap0 get_status` 检查 AP 是否均为 `ENABLED`，并确认两个接口都接入 `br-lan`。 [Photonicat 硬件说明](https://lists.openwrt.org/pipermail/linux-rockchip/2025-January/054607.html)

## 参考资料

- [photonicat-hacks](https://github.com/openwrtkitty/photonicat-hacks)
