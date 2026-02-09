# dotfiles

GNU Stow-based dotfiles for macOS. Modular packages → symlinked to target locations. Per-machine package sets.

## Commands

```bash
./stow_all.zsh <machine>              # Deploy packages for a machine
./stow_all.zsh <machine> --dry-run    # Preview only

brew bundle --file=Brewfile            # Base Homebrew packages (all machines)
brew bundle --file=Brewfile.<machine>  # Machine-specific Homebrew packages

stow -t ~ home                         # Stow single package
stow -d config -t ~/.config ghostty    # Stow config package
stow -D -t ~ home                      # Unstow (remove symlinks)
```

## Package Categories

### HOME_PKGS (`home/`)

`home/file` → `~/file` — Shell (.zshrc) and git config. All machines.

### CONFIG_PKGS (`config/`)

`config/$pkg/$pkg/file` → `~/.config/$pkg/file` — XDG-compliant apps.

IMPORTANT: Double-nesting required for correct symlinks.

### EXTRA_PKGS (root dirs)

`$pkg/path/to/file` → `~/path/to/file` — Non-standard locations (`~/.claude/`, `~/Library/Application Support/`).

## Package Distribution

Base packages → all machines. Machine-specific → `case` block in `stow_all.zsh`. Check the script for current distribution.

## Adding Packages

**~/.config app** → Create `config/$app/$app/` + add to `CONFIG_PKGS` in `stow_all.zsh`

**Home directory file** → Add to `home/`

**Non-standard location** → Create `$app/` at repo root mirroring target path + add to `EXTRA_PKGS` in `stow_all.zsh`

**New machine** → Add `case` block in `stow_all.zsh` + create `Brewfile.<machine>`

## Commit Conventions

Category prefixes: `(terminal)` | `(zsh)` | `(window)` | `(brew)` | `(dev)` | `(ai)`

Example: `(terminal) replace Warp by Ghostty`

## Notes

- Never commit secrets → use `.extra` for local-only zsh overrides (sourced by `.zshrc`, not tracked)
- Always `--dry-run` before deploying
- `.stow-local-ignore` prevents `.DS_Store` and similar from being symlinked
- Missing package directories are skipped gracefully
