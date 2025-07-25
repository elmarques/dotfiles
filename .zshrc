#!/bin/zsh

# functions
run_script() {
  [ -s "$1" ] && . "$1"
}

clear_history() {
  echo -n >|"$HISTFILE"
  fc -p "$HISTFILE"
  echo >&2 "History file deleted."
}

# dev
export EDITOR="cursor"
export VISUAL="cursor"
export XDG_CONFIG_HOME="$HOME/.config"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
run_script "$BUN_INSTALL/_bun"

# fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# uv
export PATH="$HOME/.local/bin:$PATH"

# zsh history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# zsh on exit
zshexit() {
  clear_history
}

# starship
eval "$(starship init zsh)"

# zsh plugins
run_script "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
run_script "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zoxide
eval "$(zoxide init zsh)"

# eza
alias l="eza --color=always --icons=always --all --long --no-permissions --no-filesize --no-user --no-time"

# extra
run_script "$HOME/.extra"
