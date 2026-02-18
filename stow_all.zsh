#!/usr/bin/env zsh

set -euo pipefail

cd "${0:A:h}"

# ── Packages ────────────────────────────────────────────────────────

typeset -a HOME_PKGS=(home)

typeset -a CONFIG_PKGS=()
typeset -a EXTRA_PKGS=(codex claude)
typeset -a ENSURE_DIRS=("$HOME/.config")

case "${1:-}" in
  ada)
    CONFIG_PKGS+=(aerospace ghostty opencode)
    EXTRA_PKGS+=(vscode)
    ENSURE_DIRS+=("$HOME/Library/Application Support/Code/User")
    ;;
  minnie)
    ;;
  *)
    print "Usage: ${0:t} <machine> [--dry-run]"
    print "Machines: ada, minnie"
    exit 1
    ;;
esac

dry_run=false
[[ "${2:-}" == "--dry-run" ]] && dry_run=true

# ── Helpers ─────────────────────────────────────────────────────────

stow_cmd() {
  local args=("$@")
  $dry_run && args=(-n "${args[@]}")
  print -- "+ stow ${args[*]}"
  stow --no-folding "${args[@]}"
}

# ── Stow ────────────────────────────────────────────────────────────

for dir in "${ENSURE_DIRS[@]}"; do mkdir -p "$dir"; done

stow_cmd -t ~ "${HOME_PKGS[@]}"

for pkg in "${CONFIG_PKGS[@]}"; do
  [[ -d "config/$pkg" ]] || continue
  stow_cmd -d config -t ~/.config "$pkg"
done

for pkg in "${EXTRA_PKGS[@]}"; do
  stow -D -t ~ "$pkg" 2>/dev/null || true
  find "$pkg" -type f -not -name ".stow-local-ignore" | while read -r file; do
    target="$HOME/${file#$pkg/}"
    [[ -f "$target" && ! -L "$target" ]] && rm "$target"
  done
  stow_cmd -t ~ "$pkg"
done
