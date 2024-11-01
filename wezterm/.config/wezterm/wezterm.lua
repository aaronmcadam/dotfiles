local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"
config.font_size = 18

local regular_font = "Monaspace Neon"
local italic_font = "Monaspace Radon"
config.font = wezterm.font({ family = regular_font, weight = "Regular" })
config.font_rules = {
	-- For Bold-but-not-italic text, use this relatively bold font, and override
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = regular_font,
			weight = "Bold",
		}),
	},

	-- Bold-and-italic
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font({
			family = italic_font,
			weight = "Bold",
			italic = true,
		}),
	},

	-- normal-intensity-and-italic
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = italic_font,
			weight = "Regular",
			italic = true,
		}),
	},

	-- half-intensity-and-italic (half-bright or dim); use a lighter weight font
	{
		intensity = "Half",
		italic = true,
		font = wezterm.font({
			family = italic_font,
			weight = "Light",
			italic = true,
		}),
	},

	-- half-intensity-and-not-italic
	{
		intensity = "Half",
		italic = false,
		font = wezterm.font({
			family = regular_font,
			weight = "Light",
		}),
	},
}

config.enable_kitty_graphics = true
config.enable_tab_bar = false
config.window_background_opacity = 0.95
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE"

return config
