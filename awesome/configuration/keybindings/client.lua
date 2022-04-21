local awful = require "awful"

local M = {}

M.restore_client = function()
  local c = awful.client.restore()
  -- Focus restored client
  if c then
    c:emit_signal("request::activate", "key.unminimize", { raise = true })
  end
end

M.focus_next_client = function()
  awful.client.focus.byidx(1)
  if client.focus then
    client.focus:raise()
  end
end

M.focus_prev_client = function()
  awful.client.focus.byidx(-1)
  if client.focus then
    client.focus:lower()
  end
end

M.swap_with_next_client = function()
  awful.client.swap.byidx(1)
end

M.swap_with_prev_client = function()
  awful.client.swap.byidx(-1)
end

M.kill_client = function(c)
  c:kill()
end

M.move_to_screen = function(c)
  c:move_to_screen()
end

M.minimize_client = function(c)
  c.minimized = true
end

M.maximize_client = function(c)
  c.maximized = not c.maximized
  c:raise()
end

-- BUG: doesn't work...getmaster is deprecated
M.move_to_master = function(c)
  c:swap(awful.client.getmaster())
end

M.maximize_vertically = function(c)
  c.maxmized_vertical = not c.maxmized_vertical
  c:raise()
end

M.toggle_fullscreen = function(c)
  c.fullscreen = not c.fullscreen
  c:raise()
end

M.toggle_sticky = function(c)
  c.floating = not c.floating
  c.width = 400
  c.height = 200
  awful.placement.bottom_right(c)
  c.sticky = not c.sticky
end

M.maximize_horizontally = function(c)
  c.maximized_horizontal = not c.maximized_horizontal
  c:raise()
end

return M
