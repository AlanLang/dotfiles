## install stow
in macos
```bash
brew install stow
```
in ubuntu/debain
```bash
sudo apt install stow
```

## use
```bash
git clone https://github.com/AlanLang/dotfile.git ~/dotfiles
cd ~/dotfiles
stow git
```

## change linkage
```bash
stow -D zsh-starship && stow zsh
```

## Font
https://github.com/ryanoasis/nerd-fonts/releases
