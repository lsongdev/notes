---
layout: default
title: 4G Wi-Fi Modem
parent: Android
---

# 4G Wi-Fi Modem

![](https://img-blog.csdnimg.cn/1c2a316bdc164eab8c145446878fb622.png)

目前市面上很多基于高通 410 方案的 4G Wi-Fi Modem 已经被广泛应用，包括不限于以下板型：

+ UFI001B
+ UFI001C
+ UFI003
+ UFI-W-001
+ SP970

我手里买到了一个 `UFI003_MB_V002` 的版本

![](https://forum.openwrt.org/uploads/default/original/3X/9/8/98baf9cfee4c5ae919a9a0e29756323b14a9bb15.jpeg)
![](https://img-blog.csdnimg.cn/ddbd2e5eb778489eabb4b32ada65bf31.png)
![](https://img-blog.csdnimg.cn/d8a7b4fdfab84c1e8d64c3d702d19ab6.png)

按主板按钮可以进入 9008 刷机模式

安装下载好的 miko，并将 `Loader.exe` 移动到安装的路径下面

```
C:\Program Files (x86)\miko_service_tool_pro\miko_service_tool_pro
```
打开 `Loader.exe` 然后在 miko 里依次选择 `Read - Partition Backup/Earese` - 点击左下角 `Load Partition Structure` 看到右边有系统信息的输出就说明连上了。

然后点击 `Read Full Image` 选个路径，取个名字就开始全量备份救砖能用的 .bin 文件。过程会比较慢，可能要十几分钟。等到跑完进度条 100% 右边的输出显示 success 就备份好了，我们就能开始随意折腾。

```shell
ssh $1 '
# passwd
echo host > /sys/kernel/debug/usb/ci_hdrc.0/role
opkg remove --force-removal-of-dependent-packages \
    aria2 zerotier docker dockerd filebrowser samba4-server \
    shadowsocks-* shadowsocksr-* v2ray-* \
    luci-theme-argon luci-app-store luci-app-passwall2 luci-app-ttyd \
    luci-app-filetransfer luci-app-diskman luci-app-nfs luci-app-usb-printer
cat > /etc/opkg.conf <<EOF
dest root /
dest ram /tmp
lists_dir ext /var/opkg-lists
option overlay_root /overlay
arch all 1
arch noarch 1
arch aarch64_cortex-a53_neon 10
arch aarch64_cortex-a53 100
EOF
cat > /etc/opkg/distfeeds.conf <<EOF
src/gz reboot_base http://mirrors.cloud.tencent.com/lede/releases/21.02.3/packages/aarch64_cortex-a53/base
src/gz reboot_luci http://mirrors.cloud.tencent.com/lede/releases/21.02.3/packages/aarch64_cortex-a53/luci
src/gz reboot_packages http://mirrors.cloud.tencent.com/lede/releases/21.02.3/packages/aarch64_cortex-a53/packages
src/gz reboot_routing http://mirrors.cloud.tencent.com/lede/releases/21.02.3/packages/aarch64_cortex-a53/routing
src/gz reboot_telephony http://mirrors.cloud.tencent.com/lede/releases/21.02.3/packages/aarch64_cortex-a53/telephony
src/gz openwrt_kiddin9 https://op.supes.top/packages/aarch64_cortex-a53
EOF
opkg update
'
```

+ https://qust.me/post/msm8916