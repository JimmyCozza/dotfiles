local awful = require "awful"
local gears = require "gears"
local hotkeys_popup = require "awful.hotkeys_popup"

local M = {}

M.showPanel = function()
  awesome.emit_signal "panel:open"
end

return M
