---
layout: default
title: VMware
has_children: true
---

# VMware Virtualization Infrastructure

VMware is the leader in virtualization, including virtual machines, virtual data centers, virtual servers, virtual servers managed by VMware, and virtual servers managed by third-party vendors.

## VMware vSphere

VMware vSphere 是一整套虚拟化方案的总称，它通常包含以下组件：

1. [VMware ESXi](esxi), 用户将服务器虚拟化的方案
2. [VMware vCenter](vcenter), 用于管理多个 ESXi 实例

### vSphere with Kubernetes

vSphere with Kubernetes （称VwK）是 vSphere 7 里面一个功能选项，管理员可在 vCenter 里启用这个选项，然后可选择 vSphere 集群激活 VwK 功能。在启用 VwK 后，vSphere 集群中会部署 3 台虚拟机，每台虚拟机部署 Kubernetes 的 Master 节点，组成高可用的本地控制平面 （Local Control Plane) ；接着在每个 ESXi 节点的内核运行一个 Kubelet 进程（称作 Spherelet ），使 ESXi 成为 Kubernetes 的 Worker 节点。这样改造之后，vSphere 集群华丽转身成为支持现代应用 Kubernetes 集群。这个 vSphere 集群称为 “Supervisor Cluster”（主管集群）。

### Download Link

+ https://pan.baidu.com/s/1DWUObx7U5NZfLRZgUvHUMw
+ https://pan.baidu.com/s/1G1vxflR0mdrVgIqMZtDBAw?pwd=xkdv
+ https://pan.baidu.com/s/1NdmWVq7crPMUPMTUNKZfjw?pwd=e7vl
+ https://pan.baidu.com/s/1AqefO7hVPDSHs5tQXoO_mA?pwd=z5t3
+ https://pan.baidu.com/s/1DWUObx7U5NZfLRZgUvHUMw?pwd=1111
+ https://pan.baidu.com/s/1Cbn2-6eef-PB5FGCrJS2zw?pwd=1111

