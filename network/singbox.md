---
layout: default
title: Singbox
parent: Network
---

# Singbox

## 在 OpenWrt 上从 Mihomo/Clash 迁移

记录时间：2026-09-21。

目标机为 OpenWrt 25.12.5 x86_64。原服务是 Mihomo Meta，通过 TUN、Fake-IP
DNS 和 OpenWrt 策略路由接管全网流量；dnsmasq 已配置把上游 DNS 转发到
`127.0.0.1#1053`。

### 安装

OpenWrt 25.12 使用 APK。这里安装 SagerNet 官方稳定版 1.14.1，没有使用
1.15 alpha：

```sh
curl -fL -o /tmp/sing-box.apk \
  https://github.com/SagerNet/sing-box/releases/download/v1.14.1/sing-box_1.14.1_openwrt_x86_64.apk

echo '796a5eb87d2d5f47e291778ba273065e31d125164d1076d773e3e53b343301f8  /tmp/sing-box.apk' \
  | sha256sum -c -

apk add --allow-untrusted /tmp/sing-box.apk
sing-box version
```

安装过程会补充 `kmod-inet-diag`、`kmod-nfnetlink-queue` 和
`kmod-nft-queue`。后两个模块用于 TUN `auto_redirect` 的 nftables/NFQueue
路径。

### 从旧 schema 迁移

旧配置来自 sing-box 1.10/1.11 时代，在 1.14 已不能启动。主要迁移项：

- DNS server 从 `address` 改为带 `type` 的新格式；
- TUN 的 `inet4_address` 改成 `address`；
- 删除无效的 TUN `gso`；
- `dns` 和 `block` 特殊出站改为 `hijack-dns` / `reject` route action；
- inbound 的 `sniff` 字段改成 route `sniff` action；
- outbound 域名解析统一设置 `route.default_domain_resolver`；
- remote rule-set 使用 1.14 的 shared HTTP client，避免弃用警告；
- 删除 `independent_cache`，改用 4096 项缓存和 optimistic cache。

Linux/OpenWrt 上使用：

```json
{
  "type": "tun",
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

`auto_redirect` 会自动向 OpenWrt fw4 添加兼容规则，不需要手写 nftables。

### 节点更新

最初的 sing-box 配置内嵌了 2025 年的 98 个节点，实际健康检查全部失败。
当前 Clash provider 已更新，因此从以下文件转换节点：

```text
confbook/clash/proxies/cf.yaml
confbook/clash/proxies/trojanflare.yaml
```

转换脚本是 `confbook/singbox/update-providers.rb`，支持 `vless`、`trojan`、
`anytls` 和 `hysteria2`，并同步 Clash 的 mixed proxy 用户认证。脚本这次生成
37 个节点，实测多条线路可用，自动选择约 190–360 ms。

URLTest 使用扁平节点列表而不是两层嵌套分组。嵌套组在冷启动时可能先使用
provider 的第一个失效节点，使规则集下载和 DNS 同时失败。

### 业务分流

`confbook/singbox/update-rules.rb` 会读取现有 `clash/rules/*.yaml`，把 Clash
classical 规则转换成 sing-box 内联 rule-set。使用内联格式后，部署仍然只需
传一个 `config.json`，不会在路由器上留下需要单独同步的规则文件。

策略组及默认出口：

| 策略组 | 默认出口 | 包含服务 |
| --- | --- | --- |
| `AI` | `US Auto` | OpenAI、ChatGPT、Claude、Anthropic |
| `YouTube` | `Auto` | YouTube、Google Video、YT 图片域名 |
| `Google` | `Auto` | Google、Gmail、Android、Google 静态资源等 |
| `TikTok` | `US Auto` | TikTok |
| `Streaming` | `Auto` | Netflix、Twitch、BBC、ReelShort |
| `Social` | `Auto` | Telegram、Twitter、Facebook、Discord、Reddit 等 |
| `Development` | `Auto` | GitHub、Stack Overflow、WordPress |
| `Proxy` | `Auto` | 其他已知需要代理的站点 |

每个 selector 都可以在 Yacd 中改成 `Auto`、`US Auto` 或 `Direct`。`US Auto`
组
只包含名称标记为美国/US 的节点，目前为 5 个。规则优先级是：拦截 → 本地
直连 → 业务分流 → 中国 IP/域名直连 → 未匹配流量自动选择。

更新节点和规则后先做 JSON 校验：

```sh
./singbox/update-providers.rb
./singbox/update-rules.rb
jq empty singbox/config.json
```

隔离测试使用本机回环的 `2080` mixed 端口，实际验证结果：ChatGPT 选择美国
节点；YouTube、Google、Netflix 和 GitHub 选择全节点 URLTest 当时的最优日本
节点。隔离实例不会接管 TUN，不影响在线流量。

新增的策略组和出站名使用英文；provider 节点名保持订阅原文，避免扩大改名
范围，也方便与上游配置逐项核对。

### 安全切换

不能直接在远程路由器上执行“停 Clash、启动 sing-box”，否则配置错误会让
SSH 一起失联。使用 `confbook/singbox/openwrt-deploy.sh`：

- 切换前运行 `sing-box check`；
- 备份原配置；
- 另起 90 秒 watchdog；
- 启动后检查 SOCKS、透明代理和 Clash API；
- 任意一步失败都恢复 Clash；
- 全部通过后才修改开机自启动状态。

配置以 `/root/confbook/singbox/config.json` 为唯一来源，运行路径使用软连接：

```sh
ln -sfn /root/confbook/singbox/config.json /etc/sing-box/config.json
readlink /etc/sing-box/config.json
```

后续部署先在开发机提交并推送 confbook，再在路由器上 `git pull --ff-only`，然后
运行仓库内的 `singbox/openwrt-deploy.sh`。部署脚本会维护该软连接；回滚时恢复
的也是仓库配置文件内容，不会把 `/etc/sing-box/config.json` 改回普通文件。

部署脚本需要允许“Clash 已停止”这一状态：OpenWrt 上 `/etc/init.d/clash stop`
在没有 PID 文件时会返回非零。该返回值不是部署失败，脚本会忽略它，以便后续
配置更新可以幂等执行；sing-box 健康检查的失败仍会触发回滚。

### 两个容易忽略的坑

第一，OpenWrt 默认没有 `/usr/libexec/sftp-server`，新版本 `scp` 会失败：

```text
ash: /usr/libexec/sftp-server: not found
scp: Connection closed
```

使用 `scp -O` 强制旧 SCP 协议即可。

第二，切换时不要通过被 Clash Fake-IP 解析过的域名管理路由器。这次本机把
`lsong.uk` 解析成了 `198.18.24.52`；停掉 Clash 后映射消失，SSH 会立即断开。
应先从路由器确认 WAN 地址，再通过真实地址连接。

此外，不能把在 Clash 运行期间做沙箱测试产生的 sing-box DNS cache 直接带到
正式环境。缓存中可能包含 `198.18.0.0/15` Fake-IP；Clash 停止后这些地址全部
失效。正式切换前要删除 `/usr/share/sing-box/cache.db`，让 sing-box 建立干净
缓存。

### 最终状态

```text
sing-box: 1.14.1，已启用并运行
Clash: 已停止并禁用自启动
TUN: singtun0，IPv4/IPv6 均启用
DNS: 127.0.0.1:1053
Mixed proxy: 192.168.8.1:1080（沿用 Clash 用户认证）
Clash API / Yacd: http://192.168.8.1:7880/ui/
```

验证过以下项目：配置检查、节点 URLTest、SOCKS 出口、路由器透明代理、Clash
API、TUN/nftables 规则、业务分流命中，以及 sing-box 服务重启后的联网恢复。

### 回滚

```sh
/etc/init.d/sing-box stop
/etc/init.d/sing-box disable
/etc/init.d/clash enable
/etc/init.d/clash start
```

部署前的 sing-box 配置内容备份位于
`/etc/sing-box/config.json.backup-YYYYmmdd-HHMMSS`；恢复时应复制到
`/root/confbook/singbox/config.json`。

### 参考

- [sing-box Migration](https://sing-box.sagernet.org/migration/)
- [sing-box TUN inbound](https://sing-box.sagernet.org/configuration/inbound/tun/)
- [sing-box DNS](https://sing-box.sagernet.org/configuration/dns/)
- [sing-box URLTest](https://sing-box.sagernet.org/configuration/outbound/urltest/)
- [sing-box Rule Set](https://sing-box.sagernet.org/configuration/rule-set/)
- [sing-box Source Rule Set](https://sing-box.sagernet.org/configuration/rule-set/source-format/)
