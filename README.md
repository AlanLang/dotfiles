# Alan's Dotfiles

个人配置文件集合（[GNU Stow](https://www.gnu.org/software/stow/) 管理）+ macOS 一键初始化脚本。

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
| `hammerspoon` | Hammerspoon 自动化脚本（按 App 自动切换输入法，macOS） |
| `rime` | Rime 鼠须管自定义配置（小鹤双拼，链接到 `~/Library/Rime`，macOS） |
| `iterm2` | iTerm2 配色方案导出 |
| `vscode` | VS Code 用户配置 |

## macOS 一键初始化（重装系统后）

```bash
git clone https://github.com/AlanLang/dotfiles.git ~/dotfiles
cd ~/dotfiles
bash install.sh
```

| 步骤 | 内容 |
|------|------|
| Homebrew | macOS 包管理器 |
| Apps | Chrome、Ghostty、Setapp、VS Code、微信、企业微信、Bob、Hammerspoon（`Brewfile`） |
| Fonts | FiraCode Nerd Font |
| Dotfiles | stow 本仓库的 git / tmux / ghostty / lazygit / nvim / hammerspoon / rime 配置 |
| Zsh | Oh My Zsh + zsh-autosuggestions + zsh-syntax-highlighting + Starship，并 stow zsh 配置 |
| Node.js | 最新版 Node.js + pnpm |
| Neovim | 依赖安装（ripgrep / fd / fzf / lazygit…），配置由 Dotfiles 步骤 stow |
| Rime 鼠须管 | 安装鼠须管 + [rime-ice](https://github.com/iDvel/rime-ice) 方案，自定义配置由 Dotfiles 步骤 stow |
| macOS 系统设置 | Dock 居右自动隐藏；Finder 显示隐藏文件、路径栏、默认打开下载目录、清空回收站不提示 |

### 安装后手动操作

- **Rime**：点击菜单栏输入法图标 → 重新部署
- **Neovim**：首次打开会自动安装所有插件，等待完成即可
- **Hammerspoon**：首次打开需在 系统设置 → 隐私与安全性 → 辅助功能 中授权，并在其 Preferences 中勾选 "Launch Hammerspoon at login"

## 手动安装单个配置（Stow）

```bash
brew install stow   # Ubuntu/Debian: sudo apt install stow
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
```

## 快速初始化（服务器环境）

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
