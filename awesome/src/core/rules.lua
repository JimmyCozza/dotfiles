-------------------------------------------------------------------------------------------------
-- This class contains rules for float exceptions or special themeing for certain applications --
-------------------------------------------------------------------------------------------------

-- Awesome Libs
local awful = require "awful"
local ruled = require "ruled"
local beautiful = require "beautiful"

ruled.client.append_rule {
  rule = {},
  properties = {
    border_width = beautiful.border_width,
    border_color = beautiful.border_normal,
    focus = awful.client.focus.filter,
    raise = true,
    keys = require "../../mappings/client_keys",
    buttons = require "../../mappings/client_buttons",
    screen = awful.screen.preferred,
    placement = awful.placement.no_overlap + awful.placement.no_offscreen,
  },
}
-- Clients should always start as slave instead of master
ruled.client.append_rule { rule = {}, properties = {}, callback = awful.client.setslave }
ruled.client.append_rule {
  rule_any = {
    instance = {},
    class = {
      "Arandr",
      "Lxappearance",
      "kdeconnect.app",
      "zoom",
      "file-roller",
      "File-roller",
    },
    name = {},
    role = {
      "AlarmWindow",
      "ConfigManager",
      "pop-up",
    },
  },
  properties = { floating = true, titlebars_enabled = true },
}
ruled.client.append_rule {
  id = "titlebar",
  rule_any = {
    type = { "normal", "dialog", "modal", "utility" },
  },
  properties = { titlebars_enabled = true },
}
