import os
import re
import sys

THEMES = {"mocha", "latte"}

THEME_CHANGES = {
    ".config/bat/config": lambda t: f'--theme="Catppuccin {t.capitalize()}"',
    ".config/nvim/lua/plugins/catppuccin.lua": lambda t: f'flavour = "{t}",',
    ".config/starship.toml": lambda t: f'palette = "catppuccin_{t}"',
    ".config/zellij/config.kdl": lambda t: f'theme "catppuccin-{t}"',
    ".gitconfig": lambda t: f"features = catppuccin-{t}",
    ".wezterm.lua": lambda t: f'config.color_scheme = "Catppuccin {t.capitalize()}"',
    "vscode/User/settings.json": lambda t: {
        "workbench.colorTheme": f"Catppuccin {t.capitalize()}",
        "workbench.iconTheme": f"catppuccin-{t}",
    },
    "Library/Application Support/Cursor/User/settings.json": lambda t: {
        "workbench.colorTheme": f"Catppuccin {t.capitalize()}",
        "workbench.iconTheme": f"catppuccin-{t}",
    },
}


def replace_in_json(content, key, value):
    pattern = re.compile(f'(?<="{key}": ")[^"]*(?=")')
    return pattern.sub(value, content)


def switch_theme(theme, dotfiles_root):
    if theme not in THEMES:
        raise ValueError(f"Invalid theme. Use {' or '.join(THEMES)}.")

    for file_path, change_func in THEME_CHANGES.items():
        full_path = os.path.join(dotfiles_root, file_path)
        if not os.path.exists(full_path):
            print(f"File not found: {full_path}")
            continue

        with open(full_path, "r+") as f:
            content = f.read()
            new_content = content

            if file_path.endswith("settings.json"):
                update_data = change_func(theme)
                for key, value in update_data.items():
                    new_content = replace_in_json(new_content, key, value)
            else:
                for t in THEMES:
                    new_content = new_content.replace(
                        change_func(t), change_func(theme)
                    )

            if new_content != content:
                f.seek(0)
                f.write(new_content)
                f.truncate()
                print(f"Theme changed in: {full_path}")


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} [{' | '.join(THEMES)}]")
    else:
        dotfiles_root = os.path.dirname(os.path.abspath(__file__))
        switch_theme(sys.argv[1], dotfiles_root)
