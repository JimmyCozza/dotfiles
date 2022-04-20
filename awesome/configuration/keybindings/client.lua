local awful = require "awful"

local function restore_client()
  local c = awful.client.restore()
  -- Focus restored client
  if c then
    c:emit_signal("request::activate", "key.unminimize", { raise = true })
  end
end

local function focus_next_client()
  awful.client.focus.byidx(1)
  if client.focus then
    client.focus:raise()
  end
end

local function focus_prev_client()
  awful.client.focus.byidx(-1)
  if client.focus then
    client.focus:lower()
  end
end

local function swap_with_next_client()
  awful.client.swap.byidx(1)
end

local function swap_with_prev_client()
  awful.client.swap.byidx(-1)
end


local function kill_client(c)
  c:kill()
end

local function move_to_screen(c)
  c:move_to_screen()
end

local function minimize_client(c)
  c.minimized = true
end

local function maximize_client(c)
  c.maximized = not c.maximized
  c:raise()
end

-- BUG: doesn't work...getmaster is deprecated
local function move_to_master(c)
  c:swap(awful.client.getmaster())
end

local function maximize_vertically(c)
  c.maxmized_vertical = not c.maxmized_vertical
  c:raise()
end

local function toggle_fullscreen(c)
  c.fullscreen = not c.fullscreen
  c:raise()
end

local function toggle_sticky(c)
  c.floating = not c.floating
  c.width = 400
  c.height = 200
  awful.placement.bottom_right(c)
  c.sticky = not c.sticky
end

local function maximize_horizontally(c)
  c.maximized_horizontal = not c.maximized_horizontal
  c:raise()
end

-- {modifier(s) table, key string, function function, description string, group string}
local client_bindings = {
  { {modkey},        "j", focus_next_client,            "focus next client"            },
  { {modkey},        "k", focus_prev_client,            "focus prev client"            },
  { {modkey},        "u", awful.client.urgent.jumpto,   "jump to urgent client"        },
  { {modkey, ctrl},  "n", restore_client,               "restore minimized"            },
  { {modkey, shift}, "j", swap_with_next_client,        "swap with next client (index)"},
  { {modkey, shift}, "k", swap_with_prev_client,        "swap with prev client (index)"},
  { {modkey, shift}, "w", awful.client.floating.toggle, "toggle floating window"       },
}

-- {modifier(s) table, key string, function function, description string, group string}
local signal_bindings = {
  {{modkey},       "m",      maximize_client,       "maximize client"      },
  {{modkey},       "n",      minimize_client,       "minimize client"      },
  {{modkey},       "o",      move_to_screen,        "move to next screen"  },
  {{modkey},       "q",      kill_client,           "kill client"          },
  {{modkey, ctrl}, "m",      maximize_vertically,   "maximize vertically"  },
  {{modkey, ctrl}, "Return", move_to_master,        "move client to master"},
  {{modkey, shift}, "b",     toggle_fullscreen,     "toggle fullscreen"    },
  {{modkey, shift}, "f",     toggle_sticky,         "toggle sticky"        },
  {{modkey, shift}, "m",     maximize_horizontally, "maximize horizontally"},
}

return {
  standard = setKeys(client_bindings, "client"),
  signal = setKeys(signal_bindings, "client signal"),
}
