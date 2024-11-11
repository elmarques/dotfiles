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

# starship
eval "$(starship init zsh)"

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

# zellij
alias zel='zellij --session=$(basename "$PWD") --layout=dev'

# android
export ANDROID_HOME="$(brew --prefix)/share/android-commandlinetools"
export PATH="$ANDROID_HOME/emulator:$PATH"
export PATH="$ANDROID_HOME/platform-tools:$PATH"
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
