local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"

local function spawn_browser()
  awful.spawn.with_shell(browser)
end
local function spawn_screenshot()
  awful.spawn.with_shell(screenshot)
end
local function spawn_terminal()
  awful.spawn.with_shell(terminal)
end
local function spawn_filemanager()
  awful.spawn.with_shell(filemanager)
end
local function spawn_launcher()
  awful.spawn.with_shell(launcher)
end
local function spawn_notes()
  awful.spawn.with_shell(notes)
end
local function spawn_dropdown_term()
  awful.spawn.with_shell("tdrop -ma -w 63% -h 60% -x 2% alacritty")
end
local function spawn_logout()
  awful.spawn.with_shell"arcolinux-logout"
end

local launcher_keys = {
  {{ modkey },       "w",      spawn_browser,       "open browser"     },
  {{ modkey, ctrl }, "p",      spawn_screenshot,    "flameshot gui"    },
  {{ modkey },       "t",      spawn_terminal,      "open a terminal"  },
  {{ modkey },       "Return", spawn_terminal,      "open a terminal"  },
  {{ modkey },       "f",      spawn_filemanager,   "open file browser"},
  {{ modkey },       "p",      spawn_launcher,      "launch rofi"      },
  {{},               "F11",    spawn_dropdown_term, "dropdown terminal"},
  {{},               "F12",    spawn_notes,         "emacs tdrop"      },
  {{ modkey },       "x",      spawn_logout,        "exit"             },
}

return setKeys(launcher_keys, "launcher")
