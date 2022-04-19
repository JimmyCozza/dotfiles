local awful = require "awful"

local screen_bindings = {
  awful.key({ modkey, ctrl }, "j", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, ctrl }, "k", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),
  -- On the fly useless gaps change
}
return screen_bindings
