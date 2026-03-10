# --- Oh My Zsh ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""

unsetopt autocd
HIST_STAMPS="yyyy-mm-dd"

plugins=(
  zsh-autosuggestions
  z
  zsh-syntax-highlighting
  tmux
  aliases
)
zstyle ':omz:lib:directories' aliases no
source $ZSH/oh-my-zsh.sh

# --- Environment ---
export XDG_CONFIG_HOME="$HOME/.config"
export EDITOR='nvim'
export PATH="$HOME/.local/bin:$PATH"

# --- Aliases ---
alias v='nvim'
alias vi='nvim'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias t='tmux ls && read session && tmux attach -t ${session:-default} || tmux new -s ${session:-default}'
alias dc='docker-compose'
alias gz='tar -zcvf file.tar.gz'
alias ugz='tar -zxvf'
alias lg='lazygit'
alias cc='claude --dangerously-skip-permissions'

# --- Bun ---
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/Users/alan/Library/Mobile Documents/com~apple~CloudDocs/Sync/bin:$PATH"

# --- Starship prompt (must be at the end) ---
eval "$(starship init zsh)"
