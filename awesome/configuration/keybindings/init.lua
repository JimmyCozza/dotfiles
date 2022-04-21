-- keys.lua
local naughty = require("naughty")
local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"

local client_fns = require "configuration.keybindings.client"
local global_fns = require "configuration.keybindings.global"
local launcher_fns = require "configuration.keybindings.launcher"
local layout_fns = require "configuration.keybindings.layout"
local media_fns = require "configuration.keybindings.media"
local mouse_bindings = require "configuration.keybindings.mouse"
local screen_fns = require "configuration.keybindings.screen"
local tag_fns = require "configuration.keybindings.tags"

-- I want to be able to glance at keybindings and see what they do a little easier.
-- This function just wraps a stupid table so each keybinding declaration can just be a
-- table of tables aligned for readability
function convert_bindings(bindings)
  local key_bindings = {}
  for _, g_key in ipairs(bindings) do
    table.insert(key_bindings, awful.key(
      g_key[1],
      g_key[2], g_key[3],
      { description = g_key[4], group = g_key[5] })
    )
  end
  return key_bindings
end

--{modifier(s) table, key string,             function function,                description string,                      group string}
-- stylua: ignore start
local global_keys = {
  {{},                "F11",                  launcher_fns.spawn_dropdown_term, "dropdown terminal",                     "launcher"},
  {{},                "F12",                  launcher_fns.spawn_notes,         "emacs tdrop",                           "launcher"},
  {{},                "XF86AudioLowerVolume", media_fns.lower_volume,           "decrease volume",                       "media"   },
  {{},                "XF86AudioMute",        media_fns.mute,                   "mute volume",                           "media"   },
  {{},                "XF86AudioNext",        media_fns.next_track,             "playerctl next",                        "media"   },
  {{},                "XF86AudioPlay",        media_fns.play_pause,             "toggle playerctl",                      "media"   },
  {{},                "XF86AudioPrev",        media_fns.prev_track,             "playerctl previous",                    "media"   },
  {{},                "XF86AudioRaiseVolume", media_fns.raise_volume,           "increase volume",                       "media"   },
  {{ modkey },        "f",                    launcher_fns.spawn_filemanager,   "open file browser",                     "launcher"},
  {{ modkey },        "h",                    layout_fns.decrease_width,        "decrease master width factor",          "layout"  },
  {{ modkey },        "j",                    client_fns.focus_next_client,     "focus next client",                     "client"  },
  {{ modkey },        "k",                    client_fns.focus_prev_client,     "focus prev client",                     "client"  },
  {{ modkey },        "l",                    layout_fns.increase_width,        "increase master width factor",          "layout"  },
  {{ modkey },        "p",                    launcher_fns.spawn_launcher,      "launch rofi",                           "launcher"},
  {{ modkey },        "s",                    hotkeys_popup.show_help,          "show help",                             "awesome" },
  {{ modkey },        "Escape",               awful.tag.history.restore,        "go back",                               "tag"     },
  {{ modkey },        "t",                    launcher_fns.spawn_terminal,      "open a terminal",                       "launcher"},
  {{ modkey },        "u",                    awful.client.urgent.jumpto,       "jump to urgent client",                 "client"  },
  {{ modkey },        "v",                    media_fns.open_pavucontrol,       "open pavucontrol",                      "media"   },
  {{ modkey },        "w",                    launcher_fns.spawn_browser,       "open browser",                          "launcher"},
  {{ modkey },        "x",                    launcher_fns.spawn_logout,        "arcolinux logout",                      "launcher"},
  {{ modkey },        "space",                layout_fns.next_layout,           "select next",                           "layout"  },
  {{ modkey },        "Return",               launcher_fns.spawn_terminal,      "open a terminal",                       "launcher"},
  {{ modkey },        "XF86AudioLowerVolume", awful.spawn"brightnessctl s 5%-", "decrease brightness",                   "media"   },
  {{ modkey },        "XF86AudioRaiseVolume", awful.spawn"brightnessctl s +5%", "increase brightness",                   "media"   },
  {{ modkey, ctrl },  "f",                    tag_fns.set_floating_layout,      "set floating layout",                   "tag"     },
  {{ modkey, ctrl },  "h",                    layout_fns.increase_columns,      "increase the number of columns",        "layout"  },
  {{ modkey, ctrl },  "j",                    screen_fns.focus_next_screen,     "focus the next screen",                 "screen"  },
  {{ modkey, ctrl },  "k",                    screen_fns.focus_prev_screen,     "focus the previous screen",             "screen"  },
  {{ modkey, ctrl },  "l",                    layout_fns.decrease_columns,      "decrease the number of columns",        "layout"  },
  {{ modkey, ctrl },  "n",                    client_fns.restore_client,        "restore minimized",                     "client"  },
  {{ modkey, ctrl },  "p",                    launcher_fns.spawn_screenshot,    "flameshot gui",                         "launcher"},
  {{ modkey, ctrl },  "r",                    awesome.restart,                  "reload awesome",                        "awesome" },
  {{ modkey, ctrl },  "t",                    tag_fns.set_tile_layout,          "set tile layout",                       "tag"     },
  {{ modkey, ctrl },  "w",                    tag_fns.set_max_layout,           "set max layout",                        "tag"     },
  {{ modkey, shift }, "d",                    global_fns.showPanel,             "show panel",                            "awesome" },
  {{ modkey, shift }, "h",                    layout_fns.increase_masters,      "increase the number of master clients", "layout"  },
  {{ modkey, shift }, "j",                    client_fns.swap_with_next_client, "swap with next client (index)",         "client"  },
  {{ modkey, shift }, "k",                    client_fns.swap_with_prev_client, "swap with prev client (index)",         "client"  },
  {{ modkey, shift }, "l",                    layout_fns.decrease_masters,      "decrease the number of master clients", "layout"  },
  {{ modkey, shift }, "q",                    awesome.quit,                     "quit awesome",                          "awesome" },
  {{ modkey, shift }, "w",                    awful.client.floating.toggle,     "toggle floating window",                "client"  },
}

--{modifier(s) table,  key string, function function,             description string,      group string}
local client_keys = {
  {{ modkey },        "m",      client_fns.maximize_client,       "maximize client",       "client"},
  {{ modkey },        "n",      client_fns.minimize_client,       "minimize client",       "client"},
  {{ modkey },        "o",      client_fns.move_to_screen,        "move to next screen",   "client"},
  {{ modkey },        "q",      client_fns.kill_client,           "kill client",           "client"},
  {{ modkey, ctrl },  "m",      client_fns.maximize_vertically,   "maximize vertically",   "client"},
  {{ modkey, ctrl },  "Return", client_fns.move_to_master,        "move client to master", "client"},
  {{ modkey, shift }, "b",      client_fns.toggle_fullscreen,     "toggle fullscreen",     "client"},
  {{ modkey, shift }, "f",      client_fns.toggle_sticky,         "toggle sticky",         "client"},
  {{ modkey, shift }, "m",      client_fns.maximize_horizontally, "maximize horizontally", "client"},
}

-- I want to lay these out like the other ones above, but I am struggling to think of how to make it look nice.
-- At least these all have names properties as a table
-- TODO: Make the keybinding definitions uniform. Maybe this is the better constructor for readability in the long run.
local odd_balls = {
  awful.key {
    modifiers = { modkey },
    keygroup = "numrow",
    description = "only view tag",
    group = "tag",
    on_press = tag_fns.view_only_tag,
  },
  awful.key {
    modifiers = { modkey, ctrl },
    keygroup = "numrow",
    description = "toggle tag",
    group = "tag",
    on_press = tag_fns.toggle_tag,
  },
  awful.key {
    modifiers = { modkey, shift },
    keygroup = "numrow",
    description = "move focused client to tag",
    group = "tag",
    on_press = tag_fns.move_focused_client_to_tag,
  },
  awful.key {
    modifiers = { modkey, ctrl, shift },
    keygroup = "numrow",
    description = "toggle focused client on tag",
    group = "tag",
    on_press = tag_fns.toggle_focused_client_on_tag,
  },
}
-- stylua: ignore end

awful.keyboard.append_global_keybindings(convert_bindings(global_keys))
awful.keyboard.append_global_keybindings(odd_balls)
awful.mouse.append_global_mousebindings(mouse_bindings.standard)

client.connect_signal("request::default_keybindings", function()
  awful.keyboard.append_client_keybindings(convert_bindings(client_keys))
end)
client.connect_signal("request::default_mousebindings", function()
  awful.mouse.append_client_mousebindings(mouse_bindings.signal)
end)
