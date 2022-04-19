local awful = require "awful"

-- Table will be
-- { modifier, binding, action, group, description}
local client_bindings = {
  awful.key({ modkey, shift }, "j", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, shift }, "k", function()
    awful.client.swap.byidx(-1)
  end, {
    description = "swap with previous client by index",
    group = "client",
  }),
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ modkey }, "z", function()
    require("ui.pop.peek").run()
  end, { description = "peek", group = "client" }),
  awful.key({ modkey, ctrl }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" }),
  -- modkey
  -- modkey + shift
  awful.key(
    { modkey, shift },
    "w",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
}

local signal_bindings = {
  awful.key({ modkey }, "q", function(c)
    c:kill()
  end, { description = "close", group = "client" }),
  awful.key({ modkey }, "o", function(c)
    c:move_to_screen()
  end, { description = "move to screen", group = "client" }),
  awful.key({ modkey }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, { description = "minimize", group = "client" }),
  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end, { description = "(un)maximize", group = "client" }),
  -- modkey + ctrl
  awful.key({ modkey, ctrl }, "Return", function(c)
    c:swap(awful.client.getmaster())
  end, { description = "move to master", group = "client" }),
  awful.key({ modkey, ctrl }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end, { description = "(un)maximize vertically", group = "client" }),
  awful.key({ modkey, shift }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey, shift }, "b", function(c)
    c.floating = not c.floating
    c.width = 400
    c.height = 200
    awful.placement.bottom_right(c)
    c.sticky = not c.sticky
  end, { description = "toggle keep on top", group = "client" }),
  awful.key({ modkey, shift }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end, { description = "(un)maximize horizontally", group = "client" }),
  -- Single tap: Center client
  -- Double tap: Center client + Floating + Resize
}

return {
  standard = client_bindings,
  signal = signal_bindings,
}
