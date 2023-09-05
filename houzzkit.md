---
layout: default
title: HOUZZkit
---

# HOUZZkit 智能家居中枢

![](https://yinbaiyuan.github.io/assets/image/houzzkit/houzzkit_f1_show.jpg)

HOUZZkit 智能家居中枢 是创客尹白猿设计的一款针对智能的设备，主要用于家居设备的远程控制。

相比于通用设备，HOUZZkit 板载了 Zigbee 模块，可以比较优雅地连接智能家居设备。

![](https://yinbaiyuan.github.io/assets/image/houzzkit/houzzkit_f1_back_side.jpeg)

HOUZZkit 有两个 NIC 网口，左侧是 LAN 口，右侧是 WAN 口。

将 WAN 口链接路由器或交换机网关，加入到网络

+ LAN 对应 eno1，默认 192.168.55.1/24
+ WAN 对应 eno0

```shell
admin@houzzkit:~$ ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: dummy0: <BROADCAST,NOARP> mtu 1500 qdisc noop state DOWN group default qlen 1000
    link/ether c6:af:de:79:da:6b brd ff:ff:ff:ff:ff:ff
3: eno1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 42:7b:6d:86:c5:77 brd ff:ff:ff:ff:ff:ff
    inet 192.168.55.1/24 brd 192.168.55.255 scope global eno1
       valid_lft forever preferred_lft forever
    inet6 fd06:dc8c:8022:0:407b:6dff:fe86:c577/64 scope global dynamic mngtmpaddr 
       valid_lft forever preferred_lft forever
    inet6 2408:8207:78b0:b1e0:407b:6dff:fe86:c577/64 scope global dynamic mngtmpaddr 
       valid_lft 187393sec preferred_lft 100993sec
    inet6 fe80::407b:6dff:fe86:c577/64 scope link 
       valid_lft forever preferred_lft forever
4: eno0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 3e:7b:6d:86:c5:77 brd ff:ff:ff:ff:ff:ff
    inet 192.168.2.234/24 brd 192.168.2.255 scope global dynamic noprefixroute eno0
       valid_lft 42163sec preferred_lft 42163sec
    inet6 fd06:dc8c:8022::f67/128 scope global dynamic noprefixroute 
       valid_lft 42165sec preferred_lft 42165sec
    inet6 2408:8207:78b0:b1e0::f67/128 scope global dynamic noprefixroute 
       valid_lft 42165sec preferred_lft 42165sec
    inet6 fd06:dc8c:8022:0:b4fa:529d:de01:251f/64 scope global temporary dynamic 
       valid_lft 603765sec preferred_lft 85278sec
    inet6 fd06:dc8c:8022:0:af95:1f2f:a25c:1398/64 scope global mngtmpaddr noprefixroute 
       valid_lft forever preferred_lft forever
    inet6 2408:8207:78b0:b1e0:b4fa:529d:de01:251f/64 scope global temporary dynamic 
       valid_lft 187393sec preferred_lft 85278sec
    inet6 2408:8207:78b0:b1e0:df8d:c0f9:59fb:5cc0/64 scope global dynamic mngtmpaddr noprefixroute 
       valid_lft 187393sec preferred_lft 100993sec
    inet6 fe80::5e21:8040:8f8c:a399/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
5: wlan0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 40:9c:a7:0c:90:fa brd ff:ff:ff:ff:ff:ff
6: p2p0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 42:9c:a7:0c:90:fa brd ff:ff:ff:ff:ff:ff
7: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default 
    link/ether 02:42:e9:27:43:fe brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
```

 <http://houzzkit.local>

 ![](https://yinbaiyuan.github.io/assets/image/hos_doc/hos_doc_regist.jpg)


## HOUZZkit OS

HOUZZkit 项目比较有野心的一个部分就是它搭载了 HOUZZkit OS ，它是一个基于 Linux/Ubuntu 的操作系统，在上面做了 Web UI 来管理 Docker 容器。
 
通过容器安装 Home Assistant 之后，可以通过 HOUZZkit OS 进行配置管理，可以简化部署过程。

### 系统安装

 + [官方固件](https://pan.baidu.com/s/1uH4C5_rmPRciLv5-Yr_etw?pwd=8888)

1. 安装驱动程序
   下载 *Rockchip Driver Assistant*，当前最新版本为 *5.1.1* 。
   提供几个下载链接，任意下载一个即可。
   + [www.mediafire.com](https://www.mediafire.com/file/ijail21i7h73d5o/Rockchip_DriverAssitant_v5.1.1.zip)
   + [androiddatahost.com](https://androiddatahost.com/wp-content/uploads/Rockchip_DriverAssitant_v5.1.1.zip)
   下载后，解压缩，打开文件夹，双击 `DriverInstall.exe`，安装驱动程序。

2. 安装刷机程序
   下载 *RKDevTool on Windows*，本教程使用的版本为 v2.86、v.2.8x v.2.9x 版本都行
    提供几个下载链接，任意下载一个即可。
    + [RKDevTool_Release_v2.86-CN](https://dl.radxa.com/tools/windows/RKDevTool_Release_v2.86.zip)
    + [RKDevTool_Release_v2.84-CN](https://meta.box.lenovo.com/v/link/view/02755469abfe4930a3425742d8d31ea2)

参考官方文档 [为智能中枢刷固件](https://yinbaiyuan.github.io/firmware/firmware.html#%E4%B8%BA%E6%99%BA%E8%83%BD%E4%B8%AD%E6%9E%A2%E5%88%B7%E5%9B%BA%E4%BB%B6) 的说明。

### 启动 HOUZZkit

```shell
~$ systemctl start houzzkit
~$ systemctl status houzzkit
```

### 查看 HOUZZkit 日志

```shell
tail -f /usr/bin/houzzkit/output.log
```

### 查看 HOUZZkit 数据库

```shell
~$ sqlite3 /usr/bin/houzzkit/database/database.db
SQLite version 3.43.2 2023-10-10 13:08:14
Enter ".help" for usage hints.
sqlite> .tables
hos_app              hos_config           hos_sys
hos_app_cn           hos_device           hos_task
hos_app_config       hos_fast_visit_file  hos_user
hos_app_en           hos_function_bar
hos_app_port         hos_ha_module
sqlite>
```

### 修改用户名

如何你在第一次开机时注册的用户名是 `admin`，你可以修改用户名为 `lsong`

HOUZZkit 的用户名和系统的用户名是对应的，所以在修改用户名时应确保系统中存在该用户。

```shell
adduser lsong
chomod -a lsong -G sudo
```

然后参考上面我们提到的数据库修改用户名

```shell
update hos_user set username = 'lsong' where username = 'admin';
```