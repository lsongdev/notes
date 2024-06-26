---
layout: default
title: Xcode
parent: macOS
---

# Xcode

Xcode is an integrated development environment (IDE) for macOS. It is the IDE that powers the Apple Macintosh family of computers.

## Installing Xcode

https://developer.apple.com/download/all/

## Installing additional simulator runtimes

```shell
xcode-select -s /Applications/Xcode-beta.app
xcodebuild -runFirstLaunch
xcrun simctl runtime add "~/Downloads/iOS_18_beta_2_Simulator_Runtime.dmg"
```

https://developer.apple.com/documentation/xcode/installing-additional-simulator-runtimes