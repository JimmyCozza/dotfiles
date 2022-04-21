local awful = require "awful"

local M = {}

M.raise_volume = function()
    awful.spawn "pamixer -i 3"
    awesome.emit_signal("widget::volume")
    awesome.emit_signal("module::volume_osd:show", true)
    awesome.emit_signal("module::slider:update")
    awesome.emit_signal("widget::volume_osd:rerun")
end

M.lower_volume = function()
    awful.spawn "pamixer -d 3"
    awesome.emit_signal("widget::volume")
    awesome.emit_signal("module::volume_osd:show", true)
    awesome.emit_signal("module::slider:update")
    awesome.emit_signal("widget::volume_osd:rerun")
end

M.mute = function()
    awful.spawn "pamixer -t"
    awesome.emit_signal("widget::volume")
    awesome.emit_signal("module::volume_osd:show", true)
    awesome.emit_signal("module::slider:update")
    awesome.emit_signal("widget::volume_osd:rerun")
end

M.open_pavucontrol = function()
    awful.spawn "pavucontrol"
end

M.play_pause = function()
  awful.spawn "playerctl play-pause"
end

M.next_track = function()
  awful.spawn "playerctl next"
end

M.prev_track = function()
  awful.spawn "playerctl previous"
end

return M
