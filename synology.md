---
layout: default
title: Synology
---

# xpenology

以下介绍两种安装方案，分别是 [pocopico
](<https://github.com/pocopico>) 的 [tinycore-redpill](<https://github.com/pocopico/tinycore-redpill>) 和 [fbelavenuto](<https://github.com/fbelavenuto>) 的 [ARPL](<https://github.com/fbelavenuto/arpl>)（Automated Redpill Loader）

目前 [RedPill Loader Builder](<https://github.com/RedPill-TTG/redpill-load>) 支持的黑群晖主要型号有：

|型号|CPU|微架构|盘位|
| -------- | -------- | -------- | -------- |
|[DS918+](https://global.download.synology.com/download/Document/Hardware/DataSheet/DiskStation/18-year/DS918+/enu/Synology_DS918_Plus_Data_Sheet_enu.pdf)|Intel Celeron J3455 (2016-8-30)|Apollo Lake|9|
|[DS920+](https://www.synology.com/en-us/products/DS920+)|Intel Celeron J4125 (2019-11)|Gemini Lake Refresh|9|
|[DS3615xs](https://global.download.synology.com/download/Document/Hardware/DataSheet/DiskStation/15-year/DS3615xs/enu/Synology_DS3615xs_Data_Sheet_enu.pdf)|Intel Core i3-4130 (2013-9-1)|Haswell|36|
|[DS3617xs](https://global.download.synology.com/download/Document/Hardware/DataSheet/DiskStation/17-year/DS3617xs/enu/Synology_DS3617xs_Data_Sheet_enu.pdf)|Intel Xeon D-1527 (2015-11-1)|Broadwell|36|
|[DS3622xs+](<https://www.synology.com/en-global/products/DS3622xs+>)|Intel Xeon D-1531 (2015-11-1)|Broadwell|36|
|[DVA3221](https://global.download.synology.com/download/Document/Hardware/DataSheet/NetworkVideoRecorder/21-year/DVA3221/enu/Synology_DVA3221_Data_Sheet_enu.pdf)|Intel Atom C3538 (2017-8-15)|Denverton|32|
|[DVA1622](https://global.download.synology.com/download/Document/Hardware/DataSheet/NetworkVideoRecorder/22-year/DVA1622/enu/Synology_DVA1622_Data_Sheet_enu.pdf)|Intel Celeron J4125 (2019-11)|Gemini Lake Refresh|16|
|[DS1621+](https://global.download.synology.com/download/Document/Hardware/DataSheet/DiskStation/21-year/DS1621+/enu/Synology_DS1621_Plus_Data_Sheet_enu.pdf)|AMD Ryzen V1500B (2018-12)|Zen|16|
|[DS2422+](https://www.synology.com/en-us/products/DS2422+)|AMD Ryzen V1500B (2018-12)|Zen|24|
|[RS4021xs+](https://www.synology.com/en-us/products/RS4021xs+)|Intel Xeon D-1541 (2015-11-1)|Broadwell|40|

可以参照 [flyride](https://xpenology.com/forum/profile/39776-flyride/) 的[文章](https://xpenology.com/forum/topic/61634-dsm-7x-loaders-and-platforms/)选择黑群晖的型号。简单来说，四代及以上英特尔 CPU 且硬盘数不多于 9 个的计算机安装 DS920+，否则安装 DS3622xs+。AMD 另议。

---

## ARPL

安装方法参考 [tmyers07](<https://github.com/tmyers07>) 的[教程](<https://www.tsunati.com/blog/xpenology-7-0-1-on-esxi-7-x>)、[flyride](https://xpenology.com/forum/profile/39776-flyride/) 的[教程 1](<https://xpenology.com/forum/topic/62547-tutorial-install-dsm-7x-with-tinycore-redpill-tcrp-loader-on-esxi/>) 和[教程 2](<https://xpenology.com/forum/topic/62221-tutorial-installmigrate-to-dsm-7x-with-tinycore-redpill-tcrp-loader/>)。https://www.chiphell.com/thread-2497442-1-1.html

0. 下载 [arpl-1.1-beta2a.img.zip](<https://github.com/fbelavenuto/arpl/releases>) 文件将 img 写入到 U 盘中。
1. 进入 arpl，可通过 ssh 操作，也可以在网页上操作端口是 7681。
2. Choose a model -> DS3622xs+。
3. Choose a build number -> 42962。
4. Choose a serial number -> Generate a random serial number。
5. Cmdline menu -> Add/edit a cmdline item -> SataPortMap -> 144。参考该 [issue](<https://github.com/fbelavenuto/arpl/issues/103#issuecomment-1216806204>)。
6. Cmdline menu -> Add/edit a cmdline item -> DiskIdxMap -> 310000。
7. Build the loader。
8. Boot the loader。
9. 选择进入『DS3622xs+ v7.1.1-42962 Beta (SATA, Verbose)』。
10. 约 1 分钟后，本地计算机浏览器访问 <http://find.synology.com> 或使用 [Synology Assistant](<https://www.synology.com/en-us/support/download/DS3622xs+?version=7.1#utilities>)，寻找本地网络中的黑群晖。
11. 找到黑群晖后，按提示在线安装或者手动上传已下载的 DSM_DS3622xs+_42962.pat，安装 DSM v7.1.1-42962。
12. 按页面提示等待几分钟后，登录 DSM，按提示进行初始化设置，此处不赘述。
13. 重启。

---

## 参考
1. [tinycore-redpill](<https://github.com/pocopico/tinycore-redpill>)
2. [**Xpenology 7.0.1 on ESXi 7.x**](<https://www.tsunati.com/blog/xpenology-7-0-1-on-esxi-7-x>)
3. [Tutorial: Install DSM 7.x with TinyCore RedPill (TCRP) Loader on ESXi](<https://xpenology.com/forum/topic/62547-tutorial-install-dsm-7x-with-tinycore-redpill-tcrp-loader-on-esxi/>)
4. [Tutorial: Install/Migrate to DSM 7.x with TinyCore RedPill (TCRP) Loader](<https://xpenology.com/forum/topic/62221-tutorial-installmigrate-to-dsm-7x-with-tinycore-redpill-tcrp-loader/>)
5. [How to passthrough SATA drives directly on VMWare EXSI 6.5 as RDMs](<https://gist.github.com/Hengjie/1520114890bebe8f805d337af4b3a064>)
6. [docker-xpenology-open-vm-tools](<https://github.com/yale-wp/docker-xpenology-open-vm-tools>)
7. [Experiment on sata_args in grub.cfg](<https://gugucomputing.wordpress.com/2018/11/11/experiment-on-sata_args-in-grub-cfg>)
8. [ESXi 6.7 client GUI broken - cnMaestro OVA upload fails at times](<https://community.cambiumnetworks.com/t/esxi-6-7-client-gui-broken-cnmaestro-ova-upload-fails-at-times/61731>)
9. [WikiChip](<https://en.wikichip.org>)
10. [群晖官网](<https://www.synology.com>)
11. [DSM 7.x Loaders and Platforms](https://xpenology.com/forum/topic/61634-dsm-7x-loaders-and-platforms/)
12. [Configuring Sataportmap](<https://xpenology.com/forum/topic/35937-configuring-sataportmap/#comment-172654>)
https://github.com/zenghongtu/blog/issues/22