local awful = require "awful"

local screen_bindings = {
  awful.key({ modkey, ctrl }, "j", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, ctrl }, "k", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),
  -- On the fly useless gaps change
  awful.key({ modkey }, "=", function()
    helpers.resize_gaps(5)
  end, { description = "add gaps", group = "screen" }),
  awful.key({ modkey }, "-", function()
    helpers.resize_gaps(-5)
  end, { description = "subtract gaps", group = "screen" }),
  -- On the fly padding change
  awful.key({ modkey, shift }, "=", function()
    helpers.resize_padding(5)
  end, { description = "add padding", group = "screen" }),
  awful.key({ modkey, shift }, "-", function()
    helpers.resize_padding(-5)
  end, { description = "subtract padding", group = "screen" }),
}
return screen_bindings
