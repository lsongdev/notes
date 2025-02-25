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


## Xcode LLM

```shell
# For XcodeLLM
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override xcodellm
# For Apple Intelligence
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override greymatter
# For Apple Intelligence + Cleanup
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override greymatter+strontium
# For XcodeLLM + Apple Intelligence + Cleanup
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override xcodellm+greymatter+strontium
# For iPhone Mirroring
curl -L https://raw.githubusercontent.com/Kyle-Ye/XcodeLLMEligible/release/0.2/scripts/override.sh | bash -s -- install override iron
```

https://github.com/Kyle-Ye/XcodeLLMEligible