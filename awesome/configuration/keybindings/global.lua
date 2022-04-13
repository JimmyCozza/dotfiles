local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local global_keys = {
  -- Awesome stuff
  awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ modkey, shift }, "d", function()
    awesome.emit_signal "panel::open"
  end, { description = "show panel", group = "awesome" }),
  awful.key({ modkey, ctrl }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, shift }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "XF86AudioRaiseVolume", function()
    awful.spawn "brightnessctl s +5%"
  end, { description = "increase brightness", group = "awesome" }),
  awful.key({ modkey }, "XF86AudioLowerVolume", function()
    awful.spawn "brightnessctl s 5%-"
  end, { description = "decrease brightness", group = "awesome" }),
}

return global_keys
