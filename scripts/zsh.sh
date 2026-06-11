#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

install_oh_my_zsh() {
  if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "[zsh] oh-my-zsh already installed, skipping"
    return 0
  fi

  echo "[zsh] installing oh-my-zsh..."
  # RUNZSH=no: don't switch shell mid-script; CHSH=no: don't change default shell here
  RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_plugins() {
  local autosuggestions="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  local syntax_highlighting="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

  if [[ -d "$autosuggestions" ]]; then
    echo "[zsh] zsh-autosuggestions already installed, skipping"
  else
    echo "[zsh] installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$autosuggestions"
  fi

  if [[ -d "$syntax_highlighting" ]]; then
    echo "[zsh] zsh-syntax-highlighting already installed, skipping"
  else
    echo "[zsh] installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$syntax_highlighting"
  fi
}

install_starship() {
  if command -v starship &>/dev/null; then
    echo "[zsh] starship already installed, skipping"
    return 0
  fi

  echo "[zsh] installing starship..."
  curl -sS https://starship.rs/install.sh | sh -s -- --yes
}

stow_zsh() {
  if ! command -v stow &>/dev/null; then
    echo "[zsh] stow not found, skipping symlink"
    return 1
  fi

  # oh-my-zsh install creates a default ~/.zshrc; remove it before stowing
  if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
    echo "[zsh] removing oh-my-zsh generated ~/.zshrc..."
    rm "$HOME/.zshrc"
  fi

  echo "[zsh] stowing zsh config..."
  stow --dir="$DOTFILES_DIR" --target="$HOME" --restow zsh
}

install_oh_my_zsh
install_plugins
install_starship
stow_zsh

echo "[zsh] done"
