#!/bin/bash
apt update

echo "install vim"
apt install -y vim
wget https://raw.githubusercontent.com/AlanLang/dotfiles/main/vim/.vimrc -O ~/.vimrc
echo "vim installed"

echo "install tmux"
apt install -y tmux
wget https://raw.githubusercontent.com/AlanLang/dotfiles/main/tmux/.tmux.conf -O ~/.tmux.conf
wget https://raw.githubusercontent.com/AlanLang/dotfiles/main/tmux/.tmux.conf.local -O ~/.tmux.conf.local
echo "tmux installed"

echo "install fish"
apt install -y fish
chsh -s /usr/bin/fish

echo "set alise into bashrc"
echo "alias vi='vim'" >> ~/.bashrc
echo "alias t='tmux'" >> ~/.bashrc

echo "set tmux default shell"
echo "set -g default-shell /usr/bin/fish" >> ~/.tmux.conf.local
