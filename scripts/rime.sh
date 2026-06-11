#!/bin/bash
set -euo pipefail

RIME_USER_DIR="$HOME/Library/Rime"
RIME_ICE_REPO="https://github.com/iDvel/rime-ice.git"
RIME_ICE_DIR="/tmp/rime-ice"

# 鼠须管（cask "squirrel"）在 Brewfile 中，由 apps.sh 安装
install_rime_ice() {
  echo "[rime] cloning rime-ice..."
  rm -rf "$RIME_ICE_DIR"
  git clone --depth=1 "$RIME_ICE_REPO" "$RIME_ICE_DIR"

  mkdir -p "$RIME_USER_DIR"

  echo "[rime] copying rime-ice files to $RIME_USER_DIR..."
  # Copy everything except README and .git
  rsync -a --exclude='.git' --exclude='README*' --exclude='LICENSE' \
    "$RIME_ICE_DIR/" "$RIME_USER_DIR/"

  rm -rf "$RIME_ICE_DIR"
}

# 自定义配置（*.custom.yaml 等）由 dotfiles.sh 统一 stow（rime 包）
install_rime_ice

echo "[rime] done — please deploy Rime from the menu bar to take effect"
