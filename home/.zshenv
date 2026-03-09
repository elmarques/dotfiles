#!/bin/zsh
typeset -U PATH

# homebrew
if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew"
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
fi

# uv
export PATH="$HOME/.local/bin:$PATH"

# bun
export PATH="$HOME/.bun/bin:$PATH"

# unlock keychain for SSH sessions (Claude Code stores OAuth token there)
if [[ -n "$SSH_CONNECTION" ]]; then
  [[ -s "$HOME/.extra" ]] && . "$HOME/.extra"
  security unlock-keychain -p "$(op read 'op://Claudinho/Minnie Login/password')" ~/Library/Keychains/login.keychain-db 2>/dev/null
fi
