local wezterm = require "wezterm"

local aesthetics = {}

aesthetics.color_scheme = "Sonokai (Gogh)"
aesthetics.window_background_opacity = 0.90
aesthetics.hide_tab_bar_if_only_one_tab = true
aesthetics.font_size = 20

-- Configures whether the window has a title bar and/or resizable border.
aesthetics.window_decorations = "RESIZE"

return aesthetics
