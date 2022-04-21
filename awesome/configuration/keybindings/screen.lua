local awful = require "awful"

local M = {}

M.focus_next_screen = function()
  awful.screen.focus_relative(1)
end
M.focus_prev_screen = function()
  awful.screen.focus_relative(-1)
end

return M
