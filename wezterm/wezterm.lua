-- Pull in the wezterm API
local wezterm = require("wezterm")

local function font_with_fallback(name, params)
  -- local names = { name, "Apple Color Emoji", "azuki_font" }
  local names = { name }
  return wezterm.font_with_fallback(names, params)
end

local font_name = "JetBrainsMono NFM"

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.automatically_reload_config = true
config.color_scheme = "GruvboxDark"
config.enable_scroll_bar = false
config.enable_tab_bar = true
config.disable_default_key_bindings = true
config.font = font_with_fallback(font_name)
config.font_rules = {
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
}
config.font_size = 15
config.keys = {
  {
    key = "d",
    mods = "CTRL",
    action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
  },
  { key = "-", mods = "CTRL", action = wezterm.action.DecreaseFontSize },
  { key = "=", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
  { key = "c", mods = "CTRL|SHIFT", action = wezterm.action.CopyTo("ClipboardAndPrimarySelection") },
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action.PasteFrom("Clipboard") },
  { key = "w", mods = "CTRL", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
  { key = "d", mods = "CTRL|SHIFT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
  { key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
  { key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
  { key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
  { key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
  { key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "DefaultDomain" }) },
  { key = "n", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = 1 }) },
  { key = "o", mods = "LEADER", action = "ActivateLastTab" },
  { key = "p", mods = "LEADER", action = wezterm.action({ ActivateTabRelative = -1 }) },
}
config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 }
config.line_height = 1.0
config.tab_bar_at_bottom = true
config.warn_about_missing_glyphs = false
config.window_background_opacity = 0.9
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
