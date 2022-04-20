local awful = require "awful"
local gears = require "gears"
local hotkeys_popup = require "awful.hotkeys_popup"

local function showPanel()
  awesome.emit_signal "panel:open"
end

-- {modifier(s) table, key string, function function, description string, group string}
-- stylua: ignore start
local g_keys = {
  { { modkey },        "s",                    hotkeys_popup.show_help,          "show help"          },
  { { modkey },        "XF86AudioRaiseVolume", awful.spawn"brightnessctl s +5%", "increase brightness"},
  { { modkey },        "XF86AudioLowerVolume", awful.spawn"brightnessctl s 5%-", "decrease brightness"},
  { { modkey, ctrl },  "r",                    awesome.restart,                  "reload awesome"     },
  { { modkey, shift }, "d",                    showPanel,                        "show panel"         },
  { { modkey, shift }, "q",                    awesome.quit,                     "quit awesome"       },
}
-- stylua: ignore end



return setKeys(g_keys, "awesome")
