#!/bin/zsh

# functions
run_script() {
  [ -s "$1" ] && . "$1"
}

# instant prompt
run_script "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-$USER.zsh"

# dev
export EDITOR="nvim"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# asdf
run_script "$(brew --prefix)/opt/asdf/libexec/asdf.sh"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
run_script "$BUN_INSTALL/_bun"

# oh my zsh
run_script "$HOME/.oh-my-zsh/oh-my-zsh.sh"

# powerlevel10k
run_script "$HOME/.p10k.zsh"
run_script "$(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme"

# zoxide
eval "$(zoxide init zsh)"

# eza
alias l="eza --color=always --icons=always --all --long --no-permissions --no-filesize --no-user --no-time"

# fzf
eval "$(fzf --zsh)"
run_script "$HOME/.fzf.zsh"
