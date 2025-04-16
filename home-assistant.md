---
layout: default
title: Home Assistant
---

# Home Assistant

## Install

```shell

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y python3 python3-dev python3-venv python3-pip bluez libffi-dev libssl-dev libjpeg-dev zlib1g-dev autoconf build-essential libopenjp2-7 libtiff6 libturbojpeg0-dev tzdata ffmpeg liblapack3 liblapack-dev libatlas-base-dev

sudo useradd -rm homeassistant

sudo mkdir /srv/homeassistant
sudo chown homeassistant:homeassistant /srv/homeassistant

sudo -u homeassistant -H -s
cd /srv/homeassistant
python3 -m venv .
source bin/activate

python3 -m pip install wheel isal
pip3 install homeassistant==2025.4.2

hass
```

systemd

```ini
[Unit]
Description=Home Assistant
After=network-online.target

[Service]
Type=simple
User=homeassistant
ExecStart=/srv/homeassistant/bin/hass
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
```

使用方法：

1. 创建 service 文件：
```bash
sudo vim /etc/systemd/system/home-assistant.service
```

2. 复制上述配置到文件中

3. 重新加载 systemd 配置：
```bash
sudo systemctl daemon-reload
```

4. 启用并启动服务：
```bash
sudo systemctl enable home-assistant 
sudo systemctl start home-assistant
```

5. 查看服务状态：
```bash
sudo systemctl status home-assistant
```