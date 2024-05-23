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

# instant prompt
run_script "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$USER.zsh"

# dev
export EDITOR="nvim"
export VISUAL="nvim"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# asdf
run_script "$(brew --prefix)/opt/asdf/libexec/asdf.sh"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
run_script "$BUN_INSTALL/_bun"

# zsh history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history

# powerlevel10k
run_script "$HOME/.p10k.zsh"
run_script "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"

# zsh plugins
run_script "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
run_script "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# zoxide
eval "$(zoxide init zsh)"

# eza
alias l="eza --color=always --icons=always --all --long --no-permissions --no-filesize --no-user --no-time"

# fzf
eval "$(fzf --zsh)"
run_script "$HOME/.fzf.zsh"
