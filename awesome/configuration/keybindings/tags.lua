local awful = require "awful"
local naughty = require "naughty"
local hotkeys_popup = require "awful.hotkeys_popup"
local tag_keys = {
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
  awful.key({ modkey, ctrl }, "w", function()
    awful.layout.set(awful.layout.suit.max)
  end, { description = "set max layout", group = "tag" }),
  awful.key({ modkey }, "s", function()
    awful.layout.set(awful.layout.suit.tile)
  end, { description = "set tile layout", group = "tag" }),
  awful.key({ modkey, shift }, "s", function()
    awful.layout.set(awful.layout.suit.floating)
  end, { description = "set floating layout", group = "tag" }),
  awful.key {
    modifiers = { modkey },
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
      client.emit_signal("tag::switched")
    end,
  },
  awful.key {
    modifiers = { modkey, ctrl },
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end,
  },
  awful.key {
    modifiers = { modkey, shift },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  },
  awful.key {
    modifiers = { modkey, ctrl, shift },
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "tag",
    on_press = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end,
  },
}

return tag_keys
