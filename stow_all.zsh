#!/usr/bin/env zsh

set -euo pipefail

cd "${0:A:h}"

typeset -a HOME_PKGS=(home)
typeset -a CONFIG_PKGS=(
  #1Password
  aerospace
  #bat
  ghostty
  #nvim
  #sketchybar
  #skhd
  #yabai
  #zellij
)
typeset -a EXTRA_PKGS=(cursor)

dry_run=false
[[ "${1:-}" == "--dry-run" ]] && dry_run=true

ensure_dirs() {
  mkdir -p "$HOME/.config"
  mkdir -p "$HOME/Library/Application Support/Cursor/User"
}

stow_cmd() {
  local args=("$@")
  $dry_run && args=(-n "${args[@]}")
  print -- "+ stow ${args[*]}"
  stow "${args[@]}"
}

ensure_dirs

stow_cmd -t ~ "${HOME_PKGS[@]}"

for pkg in "${CONFIG_PKGS[@]}"; do
  [[ -d "config/$pkg" ]] || continue
  stow_cmd -d config -t ~/.config "$pkg"
done

for pkg in "${EXTRA_PKGS[@]}"; do
  stow_cmd -t ~ "$pkg"
done
