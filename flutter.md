---
layout: default
title: Flutter
---

# Flutter

> flutter is a development environment for building applications for mobile, web, desktop, and embedded devices.

## Install Flutter SDK

```shell
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/macos/flutter_macos_arm64_3.24.0-stable.zip
unzip flutter_macos_arm64_3.24.0-stable.zip -d /usr/local/flutter
```

## FAQ

```shell
flutter: Exception: SocketException: Connection failed (OS Error: Operation not permitted, errno = 1), address = broker.hivemq.com, port = 1883
flutter: Disconnected
flutter: ERROR: MQTT client connection failed - disconnecting, status is Connection status is disconnected with return code of noneSpecified and a disconnection origin of solicited
```

Add to `macos/Runner/Release.entitlements` and `DebugProfile.entitlements`:

```patch
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>com.apple.security.app-sandbox</key>
  <true/>
+  <key>com.apple.security.network.client</key>
+  <true/>
</dict>
</plist>
```