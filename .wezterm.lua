local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- theme
config.color_scheme = "Catppuccin Frappe"

-- font
config.font_size = 15
config.line_height = 1.2

-- window
config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.94
config.macos_window_background_blur = 24

return config
