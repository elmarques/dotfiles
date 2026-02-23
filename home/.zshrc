#!/bin/zsh
typeset -U PATH

# environment
export EDITOR="code"

# homebrew
if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
fi

# zsh
HISTSIZE=5000
SAVEHIST=0
unset HISTFILE
for plugin in zsh-autosuggestions zsh-syntax-highlighting; do
  plugin_file="${HOMEBREW_PREFIX:-/opt/homebrew}/share/$plugin/$plugin.zsh"
  [ -s "$plugin_file" ] && . "$plugin_file"
done

# starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# eza
alias l="eza --color=always --icons=always --all --long --no-permissions --no-filesize --no-user --no-time"

# uv
export PATH="$HOME/.local/bin:$PATH"

# bun
export PATH="$HOME/.bun/bin:$PATH"

# claude code
alias cc="claude --dangerously-skip-permissions"

# codex
alias cx="codex -c approval_policy=never -c sandbox_mode=danger-full-access"

# gemini
alias gm="gemini --yolo --model gemini-3.1-pro-preview"

# local overrides
[ -s "$HOME/.extra" ] && . "$HOME/.extra"
