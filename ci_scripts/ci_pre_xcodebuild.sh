#!/bin/sh

# SPMのプラグインを有効にするため
# Ref: https://zenn.dev/kyome/articles/56974297795cb5
defaults write com.apple.dt.Xcode IDESkipPackagePluginFingerprintValidatation -bool YES
