#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# 需要 stow 的包（zsh 由 zsh.sh 在安装 oh-my-zsh 之后处理）
PACKAGES=(git tmux ghostty lazygit nvim hammerspoon rime)

install_dotfiles() {
  # stow depends on brew being available
  if ! command -v brew &>/dev/null; then
    echo "[dotfiles] brew not found, cannot continue"
    exit 1
  fi

  # Install GNU Stow
  if ! command -v stow &>/dev/null; then
    echo "[dotfiles] installing stow..."
    brew install stow
  else
    echo "[dotfiles] stow already installed, skipping"
  fi

  # 预创建目标目录，让 stow 只链接文件而不是整个目录，
  # 避免运行时生成的文件（如 Hammerspoon 的 Spoons/、Rime 的词库）落进仓库
  mkdir -p "$HOME/.config" "$HOME/.hammerspoon" "$HOME/Library/Rime"

  # Stow each package
  echo "[dotfiles] symlinking configs..."
  for pkg in "${PACKAGES[@]}"; do
    if [[ -d "$DOTFILES_DIR/$pkg" ]]; then
      stow --dir="$DOTFILES_DIR" --target="$HOME" --restow "$pkg"
      echo "  stowed: $pkg"
    else
      echo "  skipped (dir not found): $pkg"
    fi
  done

  echo "[dotfiles] done"
}

install_dotfiles
