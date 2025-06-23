---
layout: default
title: macOS
parent: Apple
has_children: true
---

# macOS

macOS is a Unix-like operating system developed by Apple Inc. It is the operating system that powers the Macintosh family of computers.

Setting up a new Macbook will be tough and cumbersome. Every time I am getting a new Macbook, I go over the same steps on how to set it up for my working experience.

I create a record of my setup, hoping it's helpful for others too!

## Install

+ [Sierra 10.12](http://updates-http.cdn-apple.com/2019/cert/061-39476-20191023-48f365f4-0015-4c41-9f44-39d3d2aca067/InstallOS.dmg)
+ [El Capitan 10.11](http://updates-http.cdn-apple.com/2019/cert/061-41424-20191024-218af9ec-cf50-4516-9011-228c78eda3d2/InstallMacOSX.dmg)
+ [Yosemite 10.10](http://updates-http.cdn-apple.com/2019/cert/061-41343-20191023-02465f92-3ab5-4c92-bfe2-b725447a070d/InstallMacOSX.dmg)
+ [Mountain Lion 10.8](https://updates.cdn-apple.com/2021/macos/031-0627-20210614-90D11F33-1A65-42DD-BBEA-E1D9F43A6B3F/InstallMacOSX.dmg)
+ [Lion 10.7](https://updates.cdn-apple.com/2021/macos/041-7683-20210614-E610947E-C7CE-46EB-8860-D26D71F0D3EA/InstallMacOSX.dmg)
+ [Older versions](https://support.apple.com/en-gb/102662)

## Get started

### Dock

```shell
# Dock
defaults write com.apple.dock autohide -boolean true
defaults write com.apple.dock tilesize -int 20
defaults write com.apple.dock largesize -int 30
defaults write com.apple.dock magnification -bool true
defaults write com.apple.dock persistent-apps -array
killall Dock # restart dock app
```

### Mouse & Trackpad

#### Enable Tap to Click

When setting up a new Macbook, one of the first changes we make is enabling the tap-to-click feature for the trackpad.

Go「**System Preference -> Trackpad -> Point & Click**」and enable 「**Tap to click**」 option.

![](https://raw.githubusercontent.com/maoxiaoke/setup-a-mac-for-frontend-dev/main/enable-tap-to-click.png)

```shell
# https://apple.stackexchange.com/questions/382098/how-to-enable-tap-to-click-using-keyboard-only
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
```

#### Enable Three Finger Dragging

In general, "tap to click" on your Macbook to avoid a force-click on the trackpad. But this doesn't work when it comes to dragging and repositioning windows.

Also, I'm big fan of tree finger dragging.

1. Go 「**System Preference -> Accessibility**」.
2. In the Accessibility sidebar, choose option 「**Pointer Control**」.
3. Click the button 「**Trackpad Options**」.
4. Enable dragging and select 「**three finger drag**」.

![](https://raw.githubusercontent.com/maoxiaoke/setup-a-mac-for-frontend-dev/main/enable-three-finger-drag.png)

```shell
# https://apple.stackexchange.com/questions/110277/how-to-enable-three-finger-drag-from-command-line
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
```

#### Activate Misson Control with a mouse button

![](https://raw.githubusercontent.com/maoxiaoke/setup-a-mac-for-frontend-dev/main/mouse-mission-control.png)


#### Enable App Exposé with trackpad

"App Exposé" lets you see shows you all open and unhidden windows for your current app.

![](https://raw.githubusercontent.com/maoxiaoke/setup-a-mac-for-frontend-dev/main/app-exposé.png)

1. Go 「**System Preference -> Trackpad**」.
2. Click the 「**More Gestures**」.
3. Enable "App Exposé" and select 「**Swipe down with four fingers**」.

![](https://raw.githubusercontent.com/maoxiaoke/setup-a-mac-for-frontend-dev/main/enable-app-exposé.png)

#### Enable Stage Manager

Compared to multiple windows, I prefer [Stage Manager](https://support.apple.com/en-ph/102355). This feature arrived with macOS Ventura, and provides a little bit of ability to make your windows less cluttered.

1. Click Control Center in the menu bar, then click Stage Manager.

![](https://raw.githubusercontent.com/maoxiaoke/setup-a-mac-for-frontend-dev/main/enable-stage-manager.png)

[Mac Mouse Fix](https://github.com/lsongdev/mac-mouse-fix)


### Keyboard

repeat speed

```shell
# https://apple.stackexchange.com/questions/10467/how-to-increase-keyboard-key-repeat-rate-on-os-x
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 2
```

## Software

+ [Xcode](./xcode)
+ [Alfred](./alfred)
+ [Homebrew](./brew)
+ <https://github.com/milanvarady/Applite>
+ <https://github.com/alienator88/Pearcleaner>

## macOS 26

![](https://www.apple.com/newsroom/images/2025/06/macos-tahoe-26-makes-the-mac-more-capable-productive-and-intelligent-than-ever/article/Apple-WWDC25-macOS-Tahoe-26-hero-250609_big.jpg.large.jpg)

Rollback Launchpad to old one.

```shell
sudo mkdir -p /Library/Preferences/FeatureFlags/Domain
sudo defaults write /Library/Preferences/FeatureFlags/Domain/SpotlightUI.plist SpotlightPlus -dict Enabled -bool false

# reboot macOS
sudo reboot
```
