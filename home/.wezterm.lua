local wezterm = require("wezterm")
local config = wezterm.config_builder()
local action = wezterm.action

-- theme
config.color_scheme = "Catppuccin Mocha"

-- font
config.font_size = 15
config.line_height = 1.2
config.freetype_load_target = "Light"

-- window
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.94
config.macos_window_background_blur = 24

-- keys
config.keys = {
	{ key = "d", mods = "SUPER", action = action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{
		key = "d",
		mods = "SUPER|SHIFT",
		action = action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{ key = "w", mods = "SUPER", action = action({ CloseCurrentPane = { confirm = false } }) },
	{ key = "h", mods = "SHIFT|CTRL", action = action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "SHIFT|CTRL", action = action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "SHIFT|CTRL", action = action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "SHIFT|CTRL", action = action({ ActivatePaneDirection = "Right" }) },
}

return config
