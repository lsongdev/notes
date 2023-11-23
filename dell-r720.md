---
layout: default
title: DELL R720
---

# DELL PowerEdge r720
<img style="width:100%; max-width: 600px;" src="https://www.stalliontek.com/media/catalog/product/r/7/r720_8bay_3.5_1.jpg" />
<br />
<img style="width:100%; max-width: 600px;" src="https://cdn.bargainhardware.co.uk/media/product/c91/dell-poweredge-r720-xd-16x-sff-hot-swap-sas-psu-2u-barebones-server-829.jpg" />

+ CPU: Intel Xeon 2560
+ RAM: 64GB（24slot）
+ HDD: 12TB（3.5inch x 8Ray）
+ NIC: 4 * 1G + iDRAC
+ Power: 750W * 2

## iDRAC

https://www.dell.com/support/kbdoc/en-us/000178115/idrac9-versions-and-release-notes
https://www.dell.com/support/kbdoc/en-us/000135299/idrac7-idrac8-red007-error-when-applying-latest-idrac-firmware-from-out-of-band-interface

我们可以看到服务器的性能是比较强的，如果我们在服务器上安装操作系统那么我们可能就只有一种选择，为了能更好的发挥其作用我选择将其虚拟化，然后再使用上面的资源。

- [VMware Sphere](vmware)
    - [ESXi](vmware/esxi)
    - [vCenter](vmware/vcenter)
- Proxmox PVE

根据我的经验 VMware 的性能会好一些，而 Proxmox PVE 对机器的兼容性方面会好一些。

## Nvidia P40 GPU

![](https://www.elsa-jp.co.jp/wp-content/uploads/2019/03/nvidia_tesla_p40_3qtr_s.png)

https://www.nvidia.com/content/dam/en-zz/Solutions/design-visualization/documents/nvidia-p40-datasheet.pdf

```shell
apt-get update
apt install make gcc git
```

```shell
apt-get install linux-headers-generic
apt-get install linux-headers-$(uname -r)
```

```shell
wget https://us.download.nvidia.cn/tesla/460.106.00/NVIDIA-Linux-x86_64-460.106.00.run
```

https://askubuntu.com/questions/841876/how-to-disable-nouveau-kernel-driver


Cannot activate python venv, aborting...
https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/1120


Cannot locate TCMalloc
https://github.com/AUTOMATIC1111/stable-diffusion-webui/issues/10117


### Q&A: NAS 还是服务器？

群晖是计算机、路由器是计算机、服务器也是，只是他们的用途不一样。

如果你只是想上个网当然买个现成的路由器就行了，如果你想要搞一些复杂的网络配置，就需要自己搭建性能强劲的软路由系统。

同理，如果你只是想存个文件方便远程访问，群晖就够了。

但是如果你的需求会比较多，我想搭建 Kubernates(k8s)、VM 虚拟化、MediaServer 媒体服务器、Web Server、Database Server 或者你对性能和硬盘空间有要求，线上虚拟主机肯定不够用了，那么你需要自建服务器。