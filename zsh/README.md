# ZSH

## install 
```bash
sudo apt install zsh
```

## oh-my-zsh
```
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

### 自动提示
https://github.com/zsh-users/zsh-autosuggestions
1. Clone this repository into `$ZSH_CUSTOM/plugins` (by default `~/.oh-my-zsh/custom/plugins`)

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

2. Add the plugin to the list of plugins for Oh My Zsh to load (inside `~/.zshrc`):

```sh
plugins=( 
  zsh-autosuggestions
)
```

### 命令高亮
https://github.com/zsh-users/zsh-syntax-highlighting

Clone this repository in oh-my-zsh's plugins directory:
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
Activate the plugin in ~/.zshrc:
```
plugins=( [plugins...] zsh-syntax-highlighting)
```


### Starship
https://starship.rs/

```bash
curl -sS https://starship.rs/install.sh | sh
```
