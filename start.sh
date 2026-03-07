#!/bin/bash
set -euo pipefail

REPO_URL="https://raw.githubusercontent.com/AlanLang/dotfiles/main"

if [ "$(id -u)" -ne 0 ]; then
  echo "Please run as root (sudo bash start.sh)"
  exit 1
fi

apt update

echo "install vim"
apt install -y vim
wget "$REPO_URL/vim/.vimrc" -O ~/.vimrc
echo "vim installed"

echo "install tmux"
apt install -y tmux
wget "$REPO_URL/tmux/.tmux.conf" -O ~/.tmux.conf
wget "$REPO_URL/tmux/.tmux.conf.local" -O ~/.tmux.conf.local
echo "tmux installed"

echo "install fish"
apt install -y fish
chsh -s /usr/bin/fish

echo "set alias into bashrc"
echo "alias vi='vim'" >> ~/.bashrc
echo "alias t='tmux'" >> ~/.bashrc

echo "set tmux default shell"
echo "set -g default-shell /usr/bin/fish" >> ~/.tmux.conf.local
