local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local launcher_keys = {
  awful.key({ modkey }, "w", function()
    awful.spawn.with_shell(browser)
  end, { description = "open browser", group = "launcher" }),
  awful.key({ modkey, ctrl }, "p", function()
    awful.spawn.with_shell "flameshot gui"
  end, { description = "flameshot gui", group = "launcher" }),
  awful.key({ modkey }, "t", function()
    awful.spawn(terminal)
  end, { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey }, "Return", function()
    awful.spawn(terminal)
  end, { description = "open a terminal", group = "launcher" }),
  awful.key({ modkey }, "f", function()
    awful.spawn(filemanager)
  end, { description = "open file browser", group = "launcher" }),
  awful.key({ modkey }, "p", function()
    awful.spawn.with_shell(launcher)
  end, { description = "launch rofi", group = "launcher" }),
  awful.key({}, "F11", function()
    awful.spawn.with_shell "tdrop -ma -w 63% -h 60% -x 2% alacritty"
  end, { description = "alacritty tdrop", group = "launcher" }),
  awful.key({}, "F12", function()
    awful.spawn.with_shell "tdrop -ma -w 63% -h 60% -x 2% emacs"
  end, { description = "emacs tdrop", group = "launcher" }),
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

return launcher_keys
