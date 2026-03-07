# Alan's Dotfiles

使用 [GNU Stow](https://www.gnu.org/software/stow/) 管理的个人配置文件集合。每个子目录对应一个工具的配置，可以独立安装。

## 包含的配置

| 目录 | 说明 |
| --- | --- |
| `git` | Git 全局配置（`.gitconfig`、`.config/git/ignore`） |
| `zsh` | Zsh + Oh My Zsh + Starship 提示符 |
| `nvim` | Neovim 配置（Lua，使用 lazy.nvim 插件管理） |
| `vim` | Vim 基础配置（`.vimrc`） |
| `tmux` | Tmux 配置（基于 gpakosz/.tmux） |
| `fish` | Fish Shell 配置 |
| `ghostty` | Ghostty 终端配置 |
| `lazygit` | Lazygit Git TUI 配置（中文界面） |
| `skhd` | skhd 快捷键配置（macOS） |
| `iterm2` | iTerm2 配色方案导出 |
| `vscode` | VS Code 用户配置 |

## 安装

### 前置依赖

**macOS:**
```bash
brew install stow
```

**Ubuntu / Debian:**
```bash
sudo apt install stow
```

### 字体

需要安装 [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/releases)，推荐 **FiraCode Nerd Font**。

### 使用 Stow 安装配置

```bash
git clone https://github.com/AlanLang/dotfiles.git ~/dotfiles
cd ~/dotfiles

# 安装单个配置（例如 git）
stow git

# 安装多个配置
stow git zsh nvim tmux lazygit ghostty
```

Stow 会在 `$HOME` 创建符号链接，指向仓库中的对应文件。

### Stow 常用操作

```bash
# 安装配置（创建符号链接）
stow git

# 卸载配置（移除符号链接，不会删除仓库中的文件）
stow -D git

# 切换配置（先卸载旧的，再安装新的）
stow -D vim && stow nvim

# 重新安装（先卸载再安装，适用于配置结构变更后）
stow -R git

# 模拟运行（只显示会做什么，不实际执行）
stow -n -v git

# 安装到指定目录（默认目标是父目录，即 $HOME）
stow -t ~/.config nvim
```

### 快速初始化（服务器环境）

在新服务器上快速配置 vim + tmux + fish：

```bash
bash start.sh
```

## 常用别名

以下别名定义在 `zsh/.zshrc` 中：

| 别名 | 命令 |
| --- | --- |
| `v` / `vi` | `nvim` |
| `l` | `ls -lah` |
| `t` | 连接或创建 tmux 会话 |
| `dc` | `docker-compose` |
| `lg` | `lazygit` |
| `cc` | `claude --dangerously-skip-permissions` |
