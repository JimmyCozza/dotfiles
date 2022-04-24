local awful = require "awful"
local beautiful = require "beautiful"
local naughty = require "naughty"
local M = {}
M.manage_client = function(c)
  if awesome.startup and not c.size_hints.user_porition and not c.size_hints.program_position then
    awful.placement.no_offscreen(c)
  end
end

M.unmanage_client = function()
  if #awful.screen.focused().clients > 0 then
    awful.screen.focused().clients[1]:emit_signal("request::activate", "mouse_enter", {
      raise = true,
    })
  end
end

M.switch_tags = function()
    naughty.notify {
      preset = naughty.config.presets.critical,
      title = "SCHVEET",
      text = "Switch Tags",
    }
  if #awful.screen.focused().clients > 0 then
    awful.screen.focused().clients[1]:emit_signal("request::activate", "mouse_enter", {
      raise = true,
    })
  end
end

M.apply_border_color = function(c)
  c.border_color = global_colors.orange
end

M.reset_border_color = function(c)
  c.border_color = beautiful.border_normal
end

return M
