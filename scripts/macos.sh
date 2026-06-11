#!/bin/bash
set -euo pipefail

echo "[macos] configuring Dock..."
defaults write com.apple.dock orientation -string "right"
defaults write com.apple.dock autohide -bool true
killall Dock

echo "[macos] configuring Finder..."
# 显示隐藏文件
defaults write com.apple.finder AppleShowAllFiles -bool true
# 清空回收站不弹确认框
defaults write com.apple.finder WarnOnEmptyTrash -bool false
# 底部显示路径栏
defaults write com.apple.finder ShowPathbar -bool true
# 打开时显示下载目录（NewWindowTargetPath 需要 file:// 格式）
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"
killall Finder

echo "[macos] done"
