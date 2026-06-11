#!/bin/bash
set -euo pipefail

BREW_PACKAGES=(
  neovim
  ripgrep
  fd
  fzf
  lazygit
  stylua
  gnu-sed
  gawk
)

install_deps() {
  echo "[nvim] installing dependencies..."
  for pkg in "${BREW_PACKAGES[@]}"; do
    if brew list "$pkg" &>/dev/null; then
      echo "  already installed: $pkg"
    else
      echo "  installing: $pkg"
      brew install "$pkg"
    fi
  done

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
