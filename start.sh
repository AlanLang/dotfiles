#!/bin/bash
set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/AlanLang/dotfiles/main"

if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root (sudo bash start.sh)"
  exit 1
fi

# 追加一行到文件，已存在相同行则跳过（保证脚本可重复执行）
append_once() {
  local line="$1" file="$2"
  grep -qxF "$line" "$file" 2>/dev/null || echo "$line" >> "$file"
}

apt update

echo "install vim"
apt install -y vim
wget -q "$REPO_URL/vim/.vimrc" -O ~/.vimrc
echo "vim installed"

echo "install tmux"
apt install -y tmux
wget -q "$REPO_URL/tmux/.tmux.conf" -O ~/.tmux.conf
wget -q "$REPO_URL/tmux/.tmux.conf.local" -O ~/.tmux.conf.local
echo "tmux installed"

echo "install fish"
apt install -y fish
chsh -s /usr/bin/fish

echo "set alias into bashrc"
append_once "alias vi='vim'" ~/.bashrc
append_once "alias t='tmux'" ~/.bashrc

echo "set tmux default shell"
append_once "set -g default-shell /usr/bin/fish" ~/.tmux.conf.local
