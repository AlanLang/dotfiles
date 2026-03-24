# Neovim 配置

基于 [LazyVim](https://lazyvim.github.io/) 的个人 Neovim 配置，使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理插件。

## 安装

### 前置依赖

```bash
# Neovim >= 0.9
brew install neovim

# 必须
brew install git ripgrep fd          # 文件搜索，telescope / fzf 依赖
brew install lazygit                 # lazygit 集成（<leader>gg）
brew install node                    # LSP / treesitter 编译
brew install fzf                     # 命令行模糊搜索（LazyVim 可选用）

# 可选但推荐
brew install stylua                  # Lua 格式化
brew install prettier                # 前端文件格式化
brew install gnu-sed gawk            # 部分插件的替换/处理工具
```

### 克隆配置

如果是首次使用本仓库，配置文件位于 `~/dotfiles/nvim/`，通过 symlink 链接到 `~/.config/nvim`：

```bash
git clone <your-dotfiles-repo> ~/dotfiles
ln -s ~/dotfiles/nvim ~/.config/nvim
```

首次打开 Neovim 时，lazy.nvim 会自动安装所有插件：

```bash
nvim
```

## 插件体系

| 类别 | 来源 |
|------|------|
| 插件管理 | [lazy.nvim](https://github.com/folke/lazy.nvim) |
| 配置框架 | [LazyVim](https://lazyvim.github.io/) |
| 主题 | [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)（storm, 透明背景）|
| 光标特效 | smear-cursor（LazyVim extra）|

自定义插件配置放在 `lua/plugins/`，自定义 keymaps / autocmds / options 放在 `lua/config/`。

## 推荐配套工具

### 文件搜索

| 工具 | 用途 |
|------|------|
| [fd](https://github.com/sharkdp/fd) | 替代 `find`，速度更快，telescope 文件搜索默认使用 |
| [ripgrep (rg)](https://github.com/BurntSushi/ripgrep) | 全文搜索，telescope live_grep 依赖 |
| [fzf](https://github.com/junegunn/fzf) | 通用模糊匹配，shell 和 nvim 均可使用 |

### Git

| 工具 | 用途 |
|------|------|
| [lazygit](https://github.com/jesseduffield/lazygit) | TUI Git 客户端，`<leader>gg` 直接打开 |
| [delta](https://github.com/dandavison/delta) | 美化 git diff 输出 |

### LSP / 代码质量

| 工具 | 用途 |
|------|------|
| Node.js | 大量 LSP server（tsserver、eslint 等）需要 |
| [stylua](https://github.com/JohnnyMorganz/StyLua) | Lua 格式化，与 `stylua.toml` 配合 |
| [prettier](https://prettier.io/) | JS/TS/CSS/HTML/JSON 等格式化 |

### 终端字体

Neovim 的图标和 UI 需要 Nerd Font，推荐：

```bash
brew install --cask font-jetbrains-mono-nerd-font
# 或
brew install --cask font-hack-nerd-font
```

## 常用快捷键（LazyVim 默认）

| 快捷键 | 功能 |
|--------|------|
| `<Space>` | Leader 键 |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全局搜索（live grep）|
| `<leader>fb` | 切换 buffer |
| `<leader>e` | 文件树（neo-tree）|
| `<leader>gg` | 打开 lazygit |
| `<leader>l` | 打开 lazy.nvim 面板 |
| `<leader>cm` | 打开 Mason（LSP 管理）|

完整快捷键参考：<https://www.lazyvim.org/keymaps>

## 维护

```bash
# 更新所有插件
nvim --headless "+Lazy update" +qa

# 同步 lock 文件后提交
cd ~/dotfiles
git add nvim/lazy-lock.json
git commit -m "chore: update plugin lockfile"
```
