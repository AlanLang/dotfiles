#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

step() { echo; echo "==> $*"; }

step "Homebrew"
bash "$SCRIPT_DIR/scripts/homebrew.sh"

# 让当前 install.sh 会话立即拿到 brew，否则后续每个子脚本的 PATH 里都没有它
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

step "Apps & Fonts (Brewfile)"
bash "$SCRIPT_DIR/scripts/apps.sh"

step "Dotfiles"
bash "$SCRIPT_DIR/scripts/dotfiles.sh"

step "Zsh"
bash "$SCRIPT_DIR/scripts/zsh.sh"

step "Node.js & pnpm"
bash "$SCRIPT_DIR/scripts/node.sh"

step "Neovim"
bash "$SCRIPT_DIR/scripts/nvim.sh"

step "Rime (鼠须管)"
bash "$SCRIPT_DIR/scripts/rime.sh"

step "macOS 系统设置"
bash "$SCRIPT_DIR/scripts/macos.sh"

echo
echo "All done!"
