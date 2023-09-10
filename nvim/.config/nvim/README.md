## 使用
直接将本目录软链接到 `~/.config/nvim`

## 字体

https://github.com/Karmenzind/monaco-nerd-fonts/blob/master/fonts/Monaco%20Nerd%20Font%20Complete%20Windows%20Compatible.otf
其他字体推荐：
https://github.com/subframe7536/maple-font

## 替代 vi 和 vim

nvim ~/.zshrc
```
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
```

## 拼写检查

```
npm install -g cspell
```

## lazygit

```
brew install lazygit
```

## install gnu-sed
```
brew install gnu-sed
```

## 主题
https://github.com/mhartington/oceanic-next

## 设置透明
https://github.com/xiyaowong/nvim-transparent
```
:TransparentEnable
:TransparentDisable
:TransparentToggle
```

## 文件搜索

`:checkhealth telescope` 检查依赖
* BurntSushi/ripgrep：https://github.com/BurntSushi/ripgrep
* sharkdp/fd：https://github.com/sharkdp/fd

## 常用快捷键

## 光标移动

常用内置的快捷键
| 快捷键 | 说明 | 
|---|---|
| `h` `j` `k` `l` | 上/下/左右 | 
| `%` | 标签直接跳转 | 
| `gg` | 移动到文档顶部 | 
| `G` | 移动到文档底部 | 
| `w` | 前移一个单词，光标停在下一个单词开头 | 
| `W` | 移动下一个单词开头，但忽略一些标点 | 
| `e` | 前移一个单词，光标停在下一个单词末尾 | 
| `E` | 移动到下一个单词末尾，如果词尾有标点，则移动到标点 | 
| `b` | 后移一个单词，光标停在上一个单词开头 | 
| `B` | 移动到上一个单词开头，忽略一些标点 |

快速跳转
| 快捷键 | 说明             |
| ------ | ---------------- |
| `s{chart}{chart}`  | 通过两个单词向后查找     |
| `S{chart}{chart}`  | 通过两个单词向前查找     |
| `f{chart}{chart}`  | 通过一个单词向后查找     |
| `F{chart}{chart}`  | 通过一个单词向前查找     |
| `R{chart}`  | 通过一个单词屏幕查找     |

### 窗口管理
| 快捷键 | 说明             |
| ------ | ---------------- |
| `<leader>d`  | 横向分割窗口     |
| `<leader>x`  | 纵向分割窗口     |
| `<leader>h`  | 跳转到左窗口     |
| `<leader>j`  | 跳转到下窗口     |
| `<leader>k`  | 跳转到上窗口     |
| `<leader>l`  | 跳转到右窗口     |

### 对象操作
以选中模式`v`举例，范围以`a`举例
#### nvim-treesitter-textobjects

| 快捷键 | 说明             |
| ------ | ---------------- |
| `vaf`  | 选中当前函数     |
| `vac`  | 选中当前类的内容 |
| `vas`  | 选中当前`scope`  |
| `vad`  | 选中当前条件     |
| `vaa`  | 选中当前参数     |
| `vai`  | 选中同层级       |
| `cs'"` | 替换包围的单引号为双引号  |
| `dsf` | 删除外围的函数  |

### 跳转

- `]m`：跳到下一个函数的开始处
- `]]`：跳到下一个类的开始处
- `]s`：跳到下一个scope的开始处
- `]z`：跳到下一个fold的开始处
- `]M`：跳到下一个函数的结尾处
- `][`：跳到下一个类的结尾处
- `[m`：跳到上一个函数的开始处
- `[[`：跳到上一个类的开始处
- `[M`：跳到上一个函数的结尾处
- `[]`：跳到上一个类的结尾处
- `]d`：跳到下一个条件
- `[d`：跳到上一个条件

### 基于 LSP 的
| 快捷键 | 说明 |
| ------ | ---------------- |
| `gd`   | 跳转到定义的地方 |
| `gr`   | 列出所有引用     |
| `K`    | 显示悬浮效果     |
| `gp`    | 悬浮显示提示    |
| `gk`    | 显示上一个提示     |
| `gj`    | 显示下一个提示     |
| `<leader>rn` | 重命名     |
| `<leader>ca` | 显示操作     |
