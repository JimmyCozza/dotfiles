local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"

local M = {}

M.spawn_browser = function()
  awful.spawn.with_shell(browser)
end
M.spawn_screenshot = function()
  awful.spawn.with_shell(screenshot)
end
M.spawn_terminal = function()
  awful.spawn.with_shell(terminal)
end
M.spawn_filemanager = function()
  awful.spawn.with_shell(filemanager)
end
M.spawn_launcher = function()
  awful.spawn.with_shell(launcher)
end
M.spawn_notes = function()
  awful.spawn.with_shell(notes)
end
M.spawn_dropdown_term = function()
  awful.spawn.with_shell "tdrop -ma -w 63% -h 60% -x 2% alacritty"
end
M.spawn_logout = function()
  awful.spawn.with_shell "arcolinux-logout"
end

return M
