# --------------------------------
# Performance first
# --------------------------------
setopt NO_BEEP
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt EXTENDED_GLOB
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

# Disable slow stuff
unsetopt correct_all

# --------------------------------
# Completion (native, fast)
# --------------------------------
autoload -Uz compinit
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# --------------------------------
# Keybindings (Vim-like)
# --------------------------------
bindkey -v
bindkey '^R' history-incremental-search-backward

# --------------------------------
# Autosuggestions (lightweight)
# --------------------------------
if [[ -r /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# --------------------------------
# Syntax highlighting (must be last)
# --------------------------------
if [[ -r /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#----------------------
# starship
#----------------------
if command -v starship >/dev/null; then
  eval "$(starship init zsh)"
fi

# --------------------------------
# zoxide (smart cd)
# --------------------------------
eval "$(zoxide init zsh)"

# --------------------------------
# fzf (Fedora / Arch / Debian safe)
# --------------------------------
if command -v fzf >/dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

  for f in \
    /usr/share/fzf/shell/key-bindings.zsh \
    /usr/share/fzf/shell/completion.zsh \
    /usr/share/fzf/key-bindings.zsh \
    /usr/share/fzf/completion.zsh
  do
    [[ -r "$f" ]] && source "$f"
  done
fi


# --------------------------------
# Git aliases (minimal, useful)
# --------------------------------
alias g='git'
alias gs='git status -sb'
alias gl='git log --oneline --decorate --graph'
alias gd='git diff'

# --------------------------------
# Safety
# --------------------------------
alias rm='rm -I'
alias cp='cp -i'
alias mv='mv -i'
