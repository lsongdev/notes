---
layout: default
title: sing-box
parent: Network
---

# 在 OpenWrt 上使用 sing-box

sing-box 是一个通用代理平台。它可以在 OpenWrt 上创建 TUN 网络接口，接管
局域网流量，再根据域名、IP 地址或应用类别选择直连、代理或拒绝访问。

本文从基本概念开始，逐步完成安装、订阅更新、业务分流、安全部署和故障回滚。
示例基于 OpenWrt 25.12 x86_64 和 sing-box 1.14.1，但目录结构和维护方法也适合
其他平台。

## 先理解流量如何通过 sing-box

一条网络请求大致经过以下路径：

```text
局域网设备
   │
   ├─ DNS 查询 ──> dnsmasq ──> sing-box DNS
   │
   └─ TCP/UDP ──> TUN inbound ──> route rules
                                      ├─ Direct
                                      ├─ Auto / US Auto
                                      └─ Reject
```

配置中最常见的几个概念：

- **Inbound**：流量进入 sing-box 的入口。本文使用 TUN、DNS 和 mixed proxy。
- **Outbound**：流量离开 sing-box 的方式，例如直连、代理节点或策略组。
- **Route rule**：根据域名、IP、协议等条件选择 outbound。
- **Rule set**：可以复用的一组路由条件，例如 Google、YouTube 或中国域名。
- **Selector**：允许用户手动选择出口的策略组。
- **URLTest**：定期探测节点延迟并自动选择可用节点。
- **Clash-compatible API**：sing-box 提供的控制 API，可供 Yacd 等面板使用；
  它只是兼容接口，不代表运行时依赖 Clash。

## 最终目录结构

本文把所有 sing-box 相关文件放在同一个目录中：

```text
singbox/
├── config.json              # 实际运行配置
├── subscriptions.json       # 订阅源
├── rules.json               # 分流规则源
├── update-providers.rb      # 更新节点和策略组
├── update-rules.rb          # 将规则源同步到配置
├── openwrt-deploy.sh        # OpenWrt 安全部署脚本
└── README.md
```

OpenWrt 上使用目录级软连接：

```text
/etc/sing-box -> /root/confbook/singbox
```

这样配置、规则和维护脚本只有一个来源，不会出现 `/etc` 与 Git 工作区内容不一致
的问题。这个目录是独立的，不要求系统安装过 Clash 或保留任何 Clash 配置。

## 准备工作

开始前需要：

- 一台可以通过 SSH 管理的 OpenWrt 路由器；
- 与路由器 CPU 架构匹配的 sing-box 安装包；
- 至少一个有效的代理订阅；
- 一台安装了 Git、Ruby、curl 和 jq 的开发机；
- 路由器配置备份，以及不依赖代理的应急管理方式。

本文把“生成配置”和“运行配置”分开：Ruby 更新脚本在开发机运行，OpenWrt 只
负责运行 sing-box 和执行 POSIX shell 部署脚本。除非命令明确包含 SSH，否则
示例默认在仓库根目录执行。

## 安装 sing-box

OpenWrt 25.12 使用 APK 包管理器。下面安装经过验证的 1.14.1 x86_64 版本：

```sh
curl -fL -o /tmp/sing-box.apk \
  https://github.com/SagerNet/sing-box/releases/download/v1.14.1/sing-box_1.14.1_openwrt_x86_64.apk

echo '796a5eb87d2d5f47e291778ba273065e31d125164d1076d773e3e53b343301f8  /tmp/sing-box.apk' \
  | sha256sum -c -

apk add --allow-untrusted /tmp/sing-box.apk
sing-box version
```

安装过程会补充 TUN `auto_redirect` 所需的内核模块，例如
`kmod-nfnetlink-queue` 和 `kmod-nft-queue`。其他 CPU 架构或 OpenWrt 版本应下载
对应安装包，并使用发布页面提供的校验值。

## 准备基础配置

完整配置位于 `singbox/config.json`。初学者不必一次理解所有字段，可以先关注
以下四部分：

1. `dns`：定义国内 DNS、加密 DNS 和选择规则；
2. `inbounds`：定义 DNS、mixed proxy 和 TUN 入口；
3. `outbounds`：定义直连、自动测速、业务策略组和节点；
4. `route`：决定每类流量使用哪个出口。

本文使用的 TUN 配置如下：

```json
{
  "type": "tun",
  "tag": "tun-in",
  "interface_name": "singtun0",
  "address": [
    "172.19.0.1/30",
    "fdfe:dcba:9876::1/126"
  ],
  "mtu": 1500,
  "auto_route": true,
  "auto_redirect": true,
  "strict_route": true,
  "stack": "system"
}
```

`auto_route` 负责添加系统路由，`auto_redirect` 负责接入 OpenWrt fw4/nftables。
大多数场景不需要再手写一套透明代理防火墙规则。

配置中的 mixed proxy 和控制 API 默认监听 LAN 地址。部署前应把示例地址改成
路由器自己的 LAN IP，并为 mixed proxy 设置用户名和强密码。

## 配置订阅

sing-box 本身不提供 Clash 风格的 provider 自动展开功能，因此这里使用一个小型
更新脚本，把订阅内容转换成 sing-box outbounds。订阅清单由
`singbox/subscriptions.json` 独立管理：

```json
{
  "subscriptions": [
    {
      "tag": "provider-a",
      "url": "https://example.com/subscription"
    },
    {
      "tag": "provider-b",
      "url": "https://example.com/another-subscription",
      "user_agent": "ClashForWindows/0.20.39"
    }
  ]
}
```

当前转换器接受返回 `proxies` 数组的 Clash-compatible YAML。这里的 YAML 只是
订阅交换格式，不需要 Clash 程序或 Clash 配置文件。某些订阅服务会检查
User-Agent，可以在对应条目中单独设置 `user_agent`。

在开发机上更新节点：

```sh
./singbox/update-providers.rb
jq empty singbox/config.json
```

脚本支持当前配置使用的 `vless`、`trojan`、`anytls` 和 `hysteria2`。下载失败、
协议不支持或节点名重复时，脚本会在写入配置前退出，保留原来的可用配置。

### 自动节点组

- `Auto`：对所有节点做 URLTest，自动选择可用节点；
- `US Auto`：从当前订阅中动态筛选名称带 `美国` 或 `US` 标记的节点；
- `Direct`：不经过代理。

`US Auto` 不保存固定节点名单。订阅新增或移除美国节点后，下次更新会自动同步。
如果一个美国节点都没有匹配到，脚本会直接失败，不能静默回退到全部节点。这种
“失败关闭”策略可以避免 AI 流量在订阅改名后悄悄漂移到其他地区。

## 配置业务分流

`singbox/rules.json` 是规则的唯一源文件，使用 sing-box source rule-set 字段。
修改后运行：

```sh
./singbox/update-rules.rb
jq empty singbox/config.json
```

当前策略如下：

| 策略组 | 默认出口 | 典型服务 |
| --- | --- | --- |
| `AI` | `US Auto` | OpenAI、ChatGPT、Claude、Anthropic |
| `YouTube` | `Auto` | YouTube、Google Video |
| `Google` | `Auto` | Google、Gmail、Android |
| `TikTok` | `US Auto` | TikTok |
| `Streaming` | `Auto` | Netflix、Twitch、BBC |
| `Social` | `Auto` | Telegram、Twitter、Facebook、Discord、Reddit |
| `Development` | `Auto` | GitHub、Stack Overflow、WordPress |
| `Proxy` | `Auto` | 其他需要代理的站点 |

路由规则从上到下匹配，顺序非常重要：

1. 拦截规则；
2. 私有地址和明确的直连规则；
3. AI、YouTube、Google 等业务规则；
4. 中国 IP 和域名直连；
5. 未匹配流量使用 `Auto`。

更具体的规则应放在更通用的规则前面。例如 YouTube 规则应先于 Google 规则，
否则共享的 Google 域名可能先被 Google 策略组接管。

## 配置 DNS

示例配置让 sing-box 在 `127.0.0.1:1053` 接收 DNS 查询：

- 中国域名使用本地 UDP DNS；
- 其他域名使用经过代理访问的加密 DNS；
- `reverse_mapping` 帮助 TUN 根据已解析域名继续执行域名分流。

让 dnsmasq 把查询转发给 sing-box 前，应先确认 sing-box 能成功启动。然后根据
自己的 OpenWrt 配置设置上游，例如：

```sh
uci set dhcp.@dnsmasq[0].noresolv='1'
uci -q delete dhcp.@dnsmasq[0].server
uci add_list dhcp.@dnsmasq[0].server='127.0.0.1#1053'
uci commit dhcp
/etc/init.d/dnsmasq restart
```

如果 sing-box 停止后局域网设备完全无法解析域名，首先检查这里的转发关系。

## 部署到 OpenWrt

直接修改远程路由器上的 TUN 配置有失联风险，因此不要使用简单的“复制文件后
立即重启”。`openwrt-deploy.sh` 会执行以下步骤：

1. 使用目标机上的 sing-box 检查配置；
2. 从 `last-known-good.json` 创建部署前备份；
3. 维护 `/etc/sing-box` 到仓库目录的软连接；
4. 启动 90 秒 watchdog；
5. 重启 sing-box；
6. 检查进程、SOCKS 出口、透明代理和控制 API；
7. 全部通过后更新 `last-known-good.json`，否则自动恢复旧配置。

先提交并推送配置，再在路由器上部署：

```sh
ssh root@<router-ip> '
  cd /root/confbook &&
  git pull --ff-only origin master &&
  ./singbox/openwrt-deploy.sh
'
```

部署脚本只管理 sing-box，不会检查、停止、启动或依赖其他代理软件。配置备份
保存在 `/root/sing-box-backups`，不会污染 Git 工作区。

首次部署时，如果 `/etc/sing-box` 是普通目录，脚本会将它保留为：

```text
/etc/sing-box.before-repo-YYYYmmdd-HHMMSS
```

## 验证部署

先检查服务、软连接和 TUN：

```sh
readlink /etc/sing-box
/etc/init.d/sing-box status
sing-box check -c /etc/sing-box/config.json -D /usr/share/sing-box
ip addr show dev singtun0
nft list table inet sing-box
```

预期 `readlink` 输出仓库中的 sing-box 目录，服务状态为 `running`，并且
`singtun0` 同时具有配置中的 IPv4 和 IPv6 地址。

检查路由器自身的透明代理：

```sh
curl -fsS --max-time 20 \
  https://www.gstatic.com/generate_204 -o /dev/null
```

检查 mixed proxy 时，应从自己的配置读取认证信息，不要把密码直接写入 shell
历史。控制面板默认地址为：

```text
http://<router-lan-ip>:7880/ui/
```

在面板中确认 `Auto` 和 `US Auto` 已选择健康节点，并检查 `AI`、`YouTube`、
`Google` 等 selector 的当前出口。

## 日常更新流程

推荐在开发机完成生成和检查，再由路由器从 Git 拉取：

```sh
./singbox/update-providers.rb
./singbox/update-rules.rb
jq empty singbox/config.json
git diff --check
git diff
git commit -am 'Update sing-box configuration'
git push
```

新文件需要先执行 `git add`。完成代码审查后，再运行上一节的远程部署命令。
不要在路由器上直接修改 `/etc/sing-box/config.json`，因为它属于 Git 管理目录。

## 回滚

部署期间的错误会由 watchdog 自动回滚。需要手动恢复时，选择一份已知可用的
备份：

```sh
cp /root/sing-box-backups/config-YYYYmmdd-HHMMSS.json \
  /root/confbook/singbox/config.json
/etc/init.d/sing-box restart
```

恢复后再次运行配置检查和联网测试。不要用普通目录替换 `/etc/sing-box` 软连接。

## 常见问题

### `scp` 提示缺少 sftp-server

部分精简 OpenWrt 没有 SFTP server，新版 `scp` 默认使用 SFTP。临时传文件时
可以强制使用旧 SCP 协议：

```sh
scp -O local-file root@<router-ip>:/tmp/
```

### 配置校验通过，但启动后无法联网

依次检查：

1. `singtun0` 是否存在；
2. nftables 中是否存在 sing-box 表；
3. DNS 是否仍指向一个没有运行的旧端口；
4. 订阅节点域名是否可以通过 bootstrap DNS 解析；
5. `/tmp/singbox.log` 中第一个错误是什么。

### 从 Fake-IP 方案迁移后部分域名失效

旧代理软件可能留下 `198.18.0.0/15` 范围的 Fake-IP DNS 缓存。确认旧服务已经
停止后，清理 sing-box 的持久 DNS 缓存并重启，再让客户端刷新 DNS。不要在新旧
代理同时运行时共享 DNS 缓存。

### 远程切换时 SSH 断开

优先通过路由器真实 IP 管理设备，不要依赖可能被代理 DNS 改写的域名。部署 TUN
配置时始终保留 watchdog 和 last-known-good，不要手工停服务后再试错。

## 最佳实践

- 把订阅 URL、节点密码和 mixed proxy 密码视为秘密，不要提交到公开仓库；
- 固定并校验安装包版本，升级前先阅读 migration guide；
- 所有生成器都应先完整下载和验证，再写入正式配置；
- 地区策略筛选不到节点时应失败关闭，不要自动扩大到全部节点；
- URLTest 直接包含实际节点，避免多层自动测速组造成冷启动选择异常；
- 规则从具体到通用排列，并为关键服务保留独立 selector；
- 先做 `sing-box check`，再重启服务；
- 保存 last-known-good，并用真实网络请求验证部署，而不只检查进程是否存在；
- 让 `/etc/sing-box` 指向唯一配置源，避免多份配置逐渐漂移。

## 参考资料

- [sing-box Migration](https://sing-box.sagernet.org/migration/)
- [sing-box TUN inbound](https://sing-box.sagernet.org/configuration/inbound/tun/)
- [sing-box DNS](https://sing-box.sagernet.org/configuration/dns/)
- [sing-box URLTest](https://sing-box.sagernet.org/configuration/outbound/urltest/)
- [sing-box Rule Set](https://sing-box.sagernet.org/configuration/rule-set/)
- [sing-box Source Rule Set](https://sing-box.sagernet.org/configuration/rule-set/source-format/)
