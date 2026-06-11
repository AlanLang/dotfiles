#!/bin/bash
set -euo pipefail

# brew 依赖（neovim/ripgrep/fd/fzf/lazygit/stylua/gnu-sed/gawk）在 Brewfile 中，
# 由 apps.sh 安装；这里只装 npm 依赖
install_deps() {
  if ! command -v prettier &>/dev/null; then
    echo "[nvim] installing prettier..."
    npm install -g prettier
  else
    echo "[nvim] prettier already installed, skipping"
  fi
}

# 配置文件由 dotfiles.sh 统一 stow（nvim 包），这里只装依赖
install_deps

echo "[nvim] done (plugins will auto-install on first launch)"
