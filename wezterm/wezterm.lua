local wezterm = require("wezterm")

local function font_with_fallback(name, params)
	local names = { name, "Apple Color Emoji", "azuki_font" }
	return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrains Mono Nerd Font"
return {
	automatically_reload_config = true,
	color_scheme = "Gruvbox Dark",
	disable_default_key_bindings = true,
	font = font_with_fallback(font_name),
	font_rules = {
		{ italic = true, font = font_with_fallback(font_name, { italic = true }) },
		{
			italic = true,
			intensity = "Bold",
			font = font_with_fallback(font_name, { bold = true, italic = true }),
		},
		{
			intensity = "Bold",
			font = font_with_fallback(font_name, { bold = true }),
		},
	},
	font_size = 15,
	keys = {
		{ key = "d", mods = "CTRL",   action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{ key = "w", mods = "CTRL",   action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
		{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "DefaultDomain" })},
		{ key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
		{ key = "o", mods = "LEADER", action = "ActivateLastTab" },
		{ key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
	},
	leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
	line_height = 1.0,
	window_background_opacity = 0.7,
}
