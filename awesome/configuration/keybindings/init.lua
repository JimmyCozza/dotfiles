-- keys.lua
-- Contains Global Keys
local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
-- Custom modules

local client_bindings = require "configuration.keybindings.client"
local global_bindings = require "configuration.keybindings.global"
local launcher_bindings = require "configuration.keybindings.launcher"
local layout_bindings = require "configuration.keybindings.layout"
local media_bindings = require "configuration.keybindings.media"
local mouse_bindings = require "configuration.keybindings.mouse"
local tag_bindings = require "configuration.keybindings.tags"

awful.keyboard.append_global_keybindings(client_bindings.standard)
awful.keyboard.append_global_keybindings(global_bindings)
awful.keyboard.append_global_keybindings(launcher_bindings)
awful.keyboard.append_global_keybindings(layout_bindings)
awful.keyboard.append_global_keybindings(media_bindings)
awful.mouse.append_global_mousebindings(mouse_bindings.standard)
awful.keyboard.append_global_keybindings(tag_bindings)

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings(client_bindings.signal)
end)
client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings(mouse_bindings.signal)
end)
