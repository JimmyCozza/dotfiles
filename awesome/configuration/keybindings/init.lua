-- keys.lua
-- Contains Global Keys
local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
-- Custom modules

-- I want to be able to glance at keybindings and see what they do a little easier.
-- This function just wraps a stupid table so each keybinding declaration can just be a 
-- table of tables aligned for readability like this:
-- {modifier(s) table, key string, function function, description string, group string}
function setKeys(keys, group)
  local key_set = {}
  for _, g_key in ipairs(keys) do
    table.insert(key_set, awful.key(
      g_key[1],
      g_key[2],
      g_key[3],
      { description = g_key[4], group = group })
    )
  end
  return key_set
end

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
