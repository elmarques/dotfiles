#!/bin/zsh

# environment
export EDITOR="cursor"

# homebrew
if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
fi

# zsh
export HISTFILE=/dev/null
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

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# uv
export PATH="$HOME/.local/bin:$PATH"

# bun
export PATH="$HOME/.bun/bin:$PATH"

# claude code
alias cc="claude --dangerously-skip-permissions"

# codex
alias cx="codex -c approval_policy=never -c sandbox_mode=danger-full-access"

# gemini
alias gm="gemini --yolo --model gemini-3-pro-preview"

# local overrides
[ -s "$HOME/.extra" ] && . "$HOME/.extra"
