#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

step() { echo; echo "==> $*"; }

step "Homebrew"
bash "$SCRIPT_DIR/scripts/homebrew.sh"

step "Apps (Brewfile)"
bash "$SCRIPT_DIR/scripts/apps.sh"

step "Fonts"
bash "$SCRIPT_DIR/scripts/fonts.sh"

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
