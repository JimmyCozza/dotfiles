local awful = require "awful"
local naughty = require "naughty"
local hotkeys_popup = require "awful.hotkeys_popup"

local M = {}

M.set_max_layout = function()
  awful.layout.set(awful.layout.suit.max)
end

M.set_tile_layout = function()
  awful.layout.set(awful.layout.suit.tile)
end

M.set_floating_layout = function()
  awful.layout.set(awful.layout.suit.floating)
end

M.view_only_tag = function(index)
  local screen = awful.screen.focused()
  local tag = screen.tags[index]
  if tag then
    tag:view_only()
  end
  client.emit_signal "tag::switched"
end

M.toggle_tag = function(index)
  local screen = awful.screen.focused()
  local tag = screen.tags[index]
  if tag then
    awful.tag.viewtoggle(tag)
  end
end

M.move_focused_client_to_tag = function(index)
  if client.focus then
    local tag = client.focus.screen.tags[index]
    if tag then
      client.focus:move_to_tag(tag)
    end
  end
end

M.toggle_focused_client_on_tag = function(index)
  if client.focus then
    local tag = client.focus.screen.tags[index]
    if tag then
      client.focus:toggle_tag(tag)
    end
  end
end

return M
