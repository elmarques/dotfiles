---
description: Zap a Homebrew Cask app with deep cleanup (like brew zap++)
argument-hint: <cask-name>
---

Completely uninstall the Homebrew Cask app "$ARGUMENTS" from macOS, performing a thorough cleanup similar to specialized uninstaller apps.

## Process

Follow these steps carefully and systematically:

### 1. Verification Phase

- Verify that "$ARGUMENTS" is installed via `brew list --cask`
- If not installed, inform the user and stop
- Show the cask info with `brew info --cask $ARGUMENTS`

### 2. Uninstallation Phase

- Run `brew uninstall --cask --zap $ARGUMENTS`
- This removes the app AND executes the zap stanza which cleans common locations
- Show what was removed

### 3. Deep Cleanup Phase

Search for and remove ANY remaining files related to the app in these locations:

**~/Library locations:**

- `~/Library/Application Support/` - app data
- `~/Library/Caches/` - cache files
- `~/Library/Preferences/` - preference plists
- `~/Library/HTTPStorages/` - HTTP storage
- `~/Library/Saved Application State/` - saved states
- `~/Library/LaunchAgents/` - launch agents
- `~/Library/LaunchDaemons/` - launch daemons
- `~/Library/Logs/` - log files
- `~/Library/Cookies/` - cookies
- `~/Library/WebKit/` - WebKit data

**Search strategy:**

- Use `find ~/Library -iname "*<app-name>*" 2>/dev/null` with variations of the app name
- Try both the cask name and the actual app name (e.g., for "brave-browser", try "brave" and "bravesoftware")
- Exclude false positives (e.g., 1Password icons, Raycast assets)

**Homebrew cache cleanup:**

- Remove any cached installers in `~/Library/Caches/Homebrew/`
- Remove cask metadata in `~/Library/Caches/Homebrew/api/cask/`

### 4. Keychain Cleanup

- Search for app-related entries: `security dump-keychain 2>/dev/null | grep -i <app-name>`
- If found, remove with `security delete-generic-password -s "<service-name>"`
- Common service names follow patterns like "App Safe Storage", "com.company.app", etc.

### 5. System-Level Verification

- Check `/Applications` for any remaining app bundles
- Check `/Library` (system-level) if appropriate
- Use Spotlight search as final verification: `mdfind -name <app-name> 2>/dev/null`

### 6. Final Report

Provide a comprehensive report showing:

- ✅ What was successfully removed
- 📍 Any files that were found and deleted in cleanup phase
- 🔑 Any Keychain entries that were removed
- ✓ Final verification status
- ⚠️ Any remaining files (with justification if they're false positives like app icons in other tools)

## Safety Guidelines

**CRITICAL - Be extremely careful:**

- NEVER delete files that don't clearly belong to the target app
- NEVER use wildcards in rm commands
- ALWAYS show the user what you're about to delete before deleting
- EXCLUDE false positives (other apps' icons/assets that reference the app name)
- If unsure about a file, ASK the user before deleting
- NEVER delete system files or folders outside the app's scope

## Output Format

Keep output concise but informative. Group operations logically and use clear status indicators (✅ ✓ 📍 🔑 ⚠️).

## Example Usage

```
/zap brave-browser
/zap docker
/zap visual-studio-code
```

The goal is to leave the system in a state as if the app was NEVER installed, with zero traces remaining.
