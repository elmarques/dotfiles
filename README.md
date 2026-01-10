# dotfiles

> This file also serves as guidance for AI coding agents (Claude Code, Codex, etc.) when working in this repository.

## Overview

This is a GNU Stow-based dotfiles management system for macOS. Configurations are organized into modular packages that are symlinked to their target locations using Stow.

## Essential Commands

### Deploy All Configurations

```bash
./stow_all.zsh           # Deploy all enabled packages
./stow_all.zsh --dry-run # Preview what would be deployed
```

### Deploy Individual Packages

```bash
# Home directory package
stow -t ~ home

# Config directory package
stow -d config -t ~/.config ghostty

# Extra package
stow -t ~ claude
```

### Unstow (Remove Symlinks)

```bash
stow -D -t ~ home
stow -D -d config -t ~/.config ghostty
```

## Architecture

The repository uses three package categories, each with a specific purpose:

### 1. HOME_PKGS (`home/`)

**Target:** `~` (home directory)
**Pattern:** `home/file` → `~/file`

Contains shell configs (.zshrc) and git config.

### 2. CONFIG_PKGS (`config/`)

**Target:** `~/.config`
**Pattern:** `config/$pkg/$pkg/file` → `~/.config/$pkg/file`

**Important:** Double-nesting is required for Stow to create correct symlinks.

Manages XDG-compliant applications. Enable/disable packages by commenting/uncommenting in the `CONFIG_PKGS` array in `stow_all.zsh`.

### 3. EXTRA_PKGS (root directories)

**Target:** `~` (home directory)
**Pattern:** `$pkg/path/to/file` → `~/path/to/file`

For applications with non-standard config locations (e.g., `~/.claude/settings.json`, `~/Library/Application Support/Code/User/`).

## Git Commit Conventions

Use category prefixes in commit messages:

- `(terminal)` - Terminal emulator configs
- `(zsh)` - Shell configuration
- `(window)` - Window manager (Aerospace)
- `(brew)` - Homebrew packages
- `(dev)` - Development tools
- `(ai)` - AI coding agents (Claude Code, Cursor, etc.)

Example: `(terminal) replace Warp by Ghostty`

## Adding New Configurations

### For ~/.config Applications

1. Create `config/$app/$app/` directory (double-nesting required)
2. Place config files inside
3. Add `$app` to `CONFIG_PKGS` array in `stow_all.zsh`
4. Run `./stow_all.zsh`

### For Home Directory Files

1. Add file to `home/`
2. Run `./stow_all.zsh`

### For Non-Standard Locations

1. Create `$app/` directory at repo root
2. Mirror the full target path structure inside (e.g., `claude/.claude/settings.json`)
3. Add `$app` to `EXTRA_PKGS` array in `stow_all.zsh`
4. Run `./stow_all.zsh`

## Important Notes

- **Never commit secrets.** Use `.extra` for local-only zsh overrides (sourced by `.zshrc` but not tracked).
- **Test with --dry-run** before deploying changes to avoid breaking existing symlinks.
- **Stow ignore files** (`.stow-local-ignore`) prevent `.DS_Store` and other unwanted files from being symlinked.
- The script skips missing package directories, so commented packages in arrays don't cause errors.
