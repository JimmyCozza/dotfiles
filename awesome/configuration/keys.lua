-- keys.lua
-- Contains Global Keys
local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local helpers = require "helpers"
-- Custom modules
local machi = require "module.layout-machi"
local bling = require "module.bling"

-- Mouse Bindings
awful.mouse.append_global_mousebindings {
  awful.button({}, 4, awful.tag.viewprev),
  awful.button({}, 5, awful.tag.viewnext),
}

-- ************************************
-- Client and Tabs Bindings
-- ************************************
awful.keyboard.append_global_keybindings {
  awful.key({ altkey }, "a", function()
    bling.module.tabbed.pick_with_dmenu()
  end, { description = "pick client to add to tab group", group = "tabs" }),
  awful.key({ altkey }, "s", function()
    bling.module.tabbed.iter()
  end, { description = "iterate through tabbing group", group = "tabs" }),
  awful.key({ altkey }, "d", function()
    bling.module.tabbed.pop()
  end, {
    description = "remove focused client from tabbing group",
    group = "tabs",
  }),
  awful.key({ modkey }, "Down", function()
    awful.client.focus.bydirection "down"
    bling.module.flash_focus.flashfocus(client.focus)
  end, { description = "focus down", group = "client" }),
  awful.key({ modkey }, "Up", function()
    awful.client.focus.bydirection "up"
    bling.module.flash_focus.flashfocus(client.focus)
  end, { description = "focus up", group = "client" }),
  awful.key({ modkey }, "Left", function()
    awful.client.focus.bydirection "left"
    bling.module.flash_focus.flashfocus(client.focus)
  end, { description = "focus left", group = "client" }),
  awful.key({ modkey }, "Right", function()
    awful.client.focus.bydirection "right"
    bling.module.flash_focus.flashfocus(client.focus)
  end, { description = "focus right", group = "client" }),
  awful.key({ modkey }, "j", function()
    awful.client.focus.byidx(1)
  end, { description = "focus next by index", group = "client" }),
  awful.key({ modkey }, "k", function()
    awful.client.focus.byidx(-1)
  end, { description = "focus previous by index", group = "client" }),
  awful.key({ modkey, shift }, "j", function()
    awful.client.swap.byidx(1)
  end, { description = "swap with next client by index", group = "client" }),
  awful.key({ modkey, shift }, "k", function()
    awful.client.swap.byidx(-1)
  end, {
    description = "swap with previous client by index",
    group = "client",
  }),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto, { description = "jump to urgent client", group = "client" }),
  awful.key({ altkey }, "Tab", function()
    awesome.emit_signal "bling::window_switcher::turn_on"
  end, { description = "Window Switcher", group = "client" }),
}

-- ************************************
-- Awesomewm
-- ************************************
awful.keyboard.append_global_keybindings {
  -- Volume control
  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn "pamixer -i 3"
  end, { description = "increase volume", group = "awesome" }),
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn "pamixer -d 3"
  end, { description = "decrease volume", group = "awesome" }),
  awful.key({}, "XF86AudioMute", function()
    awful.spawn "pamixer -t"
  end, { description = "mute volume", group = "awesome" }), -- Media Control
  awful.key({}, "XF86AudioPlay", function()
    awful.spawn "playerctl play-pause"
  end, { description = "toggle playerctl", group = "awesome" }),
  awful.key({}, "XF86AudioPrev", function()
    awful.spawn "playerctl previous"
  end, { description = "playerctl previous", group = "awesome" }),
  awful.key({}, "XF86AudioNext", function()
    awful.spawn "playerctl next"
  end, { description = "playerctl next", group = "awesome" }),

  -- Screen Shots/Vids
  awful.key({}, "Print", function()
    require("ui.pop.shoot"):show()
  end, { description = "take a screenshot", group = "awesome" }),
  awful.key({ modkey }, "Print", function()
    awful.spawn.with_shell "shoot selnp"
  end, {
    description = "take a selection with no pads",
    group = "awesome",
  }),
  awful.key({ modkey, shift }, "Print", function()
    awful.spawn.with_shell "shoot sel"
  end, {
    description = "take a selection with pads",
    group = "awesome",
  }), -- Brightness
  awful.key({ modkey }, "XF86AudioRaiseVolume", function()
    awful.spawn "brightnessctl s +5%"
  end, { description = "increase brightness", group = "awesome" }),
  awful.key({ modkey }, "XF86AudioLowerVolume", function()
    awful.spawn "brightnessctl s 5%-"
  end, { description = "decrease brightness", group = "awesome" }),

  -- Awesome stuff
  awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
  awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
  awful.key({ modkey, shift }, "d", function()
    awesome.emit_signal "panel::open"
  end, { description = "show panel", group = "awesome" }),
  awful.key({ modkey, ctrl }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
  awful.key({ modkey, shift }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
  awful.key({ modkey }, "x", function()
    awful.util.spawn "arcolinux-logout"
  end, { description = "exit", group = "hotkeys" }),
  awful.key({ modkey, shift }, "e", function()
    awful.util.spawn 'emacsclient --eval "(emacs-everywhere)"'
  end, { description = "emacs everywhere", group = "hotkeys" }),
  awful.key({ modkey, shift }, "p", function()
    awful.util.spawn 'emacsclient --eval "(emacs-run-launcher)"'
  end, { description = "app launcher", group = "hotkeys" }),
}

-- ************************************
-- Layout Machi
-- ************************************
awful.keyboard.append_global_keybindings {
  awful.key({ modkey }, ".", function()
    machi.default_editor.start_interactive()
  end, {
    description = "edit the current layout if it is a machi layout",
    group = "layout",
  }),
  awful.key({ modkey }, "/", function()
    machi.switcher.start(client.focus)
  end, {
    description = "switch between windows for a machi layout",
    group = "layout",
  }),
}

-- ************************************
-- Launcher and screen
-- ************************************
awful.keyboard.append_global_keybindings {
  awful.key({ modkey, ctrl }, "j", function()
    awful.screen.focus_relative(1)
  end, { description = "focus the next screen", group = "screen" }),
  awful.key({ modkey, ctrl }, "k", function()
    awful.screen.focus_relative(-1)
  end, { description = "focus the previous screen", group = "screen" }),
  awful.key({ modkey }, "t", function()
    awful.spawn(terminal)
  end, { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey }, "s", function()
    awesome.emit_signal "scratch::music"
  end, { description = "open music", group = "scratchpad" }),
  awful.key({ modkey }, "z", function()
    require("ui.pop.peek").run()
  end, { description = "peek", group = "client" }),

  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey }, "f", function()
    awful.spawn(filemanager)
  end, { description = "open file browser", group = "launcher" }),
  awful.key({ modkey }, "p", function()
    awful.spawn.with_shell "~/.config/rofi/launchers/text/launcher.sh"
  end, { description = "launch rofi", group = "launcher" }),
  awful.key({ modkey }, "v", function()
    awesome.emit_signal "scratch::chat"
  end, { description = "open chats", group = "scratchpad" }),
  awful.key({ modkey }, "w", function()
    awful.spawn.with_shell(browser)
  end, { description = "open browser", group = "launcher" }),
  awful.key({ modkey, ctrl }, "p", function()
    awful.spawn.with_shell "flameshot gui"
  end, { description = "flameshot", group = "launcher" }),

  awful.key({ modkey }, "l", function()
    awful.tag.incmwfact(0.05)
  end, { description = "increase master width factor", group = "layout" }),
  awful.key({ modkey }, "h", function()
    awful.tag.incmwfact(-0.05)
  end, { description = "decrease master width factor", group = "layout" }),
  awful.key({ modkey, shift }, "h", function()
    awful.tag.incnmaster(1, nil, true)
  end, {
    description = "increase the number of master clients",
    group = "layout",
  }),
  awful.key({ modkey, shift }, "l", function()
    awful.tag.incnmaster(-1, nil, true)
  end, {
    description = "decrease the number of master clients",
    group = "layout",
  }),
  awful.key({ modkey, ctrl }, "h", function()
    awful.tag.incncol(1, nil, true)
  end, {
    description = "increase the number of columns",
    group = "layout",
  }),
  awful.key({ modkey, ctrl }, "l", function()
    awful.tag.incncol(-1, nil, true)
  end, {
    description = "decrease the number of columns",
    group = "layout",
  }),
  awful.key({ modkey }, "space", function()
    awful.layout.inc(1)
  end, { description = "select next", group = "layout" }),
  awful.key({ modkey, ctrl }, "w", function()
    awful.layout.set(awful.layout.suit.max)
  end, { description = "set max layout", group = "tag" }),
  awful.key({ modkey }, "s", function()
    awful.layout.set(awful.layout.suit.tile)
  end, { description = "set tile layout", group = "tag" }),
  awful.key({ modkey, shift }, "s", function()
    awful.layout.set(awful.layout.suit.floating)
  end, { description = "set floating layout", group = "tag" }),

  awful.key({ modkey, ctrl }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" }),
}

-- ************************************
-- Client management keybinds
-- ************************************
client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings {
    -- modkey
    awful.key({ modkey }, "q", function(c)
      c:kill()
    end, { description = "close", group = "client" }),
    awful.key({ modkey }, "o", function(c)
      c:move_to_screen()
    end, { description = "move to screen", group = "client" }),
    awful.key({ modkey }, "n", function(c)
      -- The client currently has the input focus, so it cannot be
      -- minimized, since minimized clients can't have the focus.
      c.minimized = true
    end, { description = "minimize", group = "client" }),
    awful.key({ modkey }, "m", function(c)
      c.maximized = not c.maximized
      c:raise()
    end, { description = "(un)maximize", group = "client" }),
    -- On the fly useless gaps change
    awful.key({ modkey }, "=", function()
      helpers.resize_gaps(5)
    end, { description = "add gaps", group = "screen" }),

    awful.key({ modkey }, "-", function()
      helpers.resize_gaps(-5)
    end, { description = "subtract gaps", group = "screen" }),
    -- Single tap: Center client
    -- Double tap: Center client + Floating + Resize
    awful.key({ modkey }, "c", function(c)
      awful.placement.centered(c, {
        honor_workarea = true,
        honor_padding = true,
      })
      helpers.single_double_tap(nil, function()
        helpers.float_and_resize(c, screen_width * 0.25, screen_height * 0.28)
      end)
    end),
    -- modkey + ctrl
    awful.key({ modkey, ctrl }, "Return", function(c)
      c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" }),
    awful.key({ modkey, ctrl }, "m", function(c)
      c.maximized_vertical = not c.maximized_vertical
      c:raise()
    end, { description = "(un)maximize vertically", group = "client" }),
    -- modkey + shift
    awful.key(
      { modkey, shift },
      "w",
      awful.client.floating.toggle,
      { description = "toggle floating", group = "client" }
    ),
    awful.key({ modkey, shift }, "f", function(c)
      c.fullscreen = not c.fullscreen
      c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey, shift }, "b", function(c)
      c.floating = not c.floating
      c.width = 400
      c.height = 200
      awful.placement.bottom_right(c)
      c.sticky = not c.sticky
    end, { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey, shift }, "m", function(c)
      c.maximized_horizontal = not c.maximized_horizontal
      c:raise()
    end, { description = "(un)maximize horizontally", group = "client" }),
    -- On the fly padding change
    awful.key({ modkey, shift }, "=", function()
      helpers.resize_padding(5)
    end, { description = "add padding", group = "screen" }),
    awful.key({ modkey, shift }, "-", function()
      helpers.resize_padding(-5)
    end, { description = "subtract padding", group = "screen" }),
  }
end)

-- ************************************
-- Num row keybinds
-- ************************************
awful.keyboard.append_global_keybindings {
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
  awful.key {
    modifiers = { modkey },
    keygroup = "numpad",
    description = "select layout directly",
    group = "layout",
    on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  },
}

client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings {
    awful.button({}, 1, function(c)
      c:activate { context = "mouse_click" }
    end),
    awful.button({ modkey }, 1, function(c)
      c:activate { context = "mouse_click", action = "mouse_move" }
    end),
    awful.button({ modkey }, 3, function(c)
      c:activate { context = "mouse_click", action = "mouse_resize" }
    end),
  }
end)

-- EOF ------------------------------------------------------------------------
