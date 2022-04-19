local awful = require "awful"
local beautiful = require "beautiful"
dpi = beautiful.xresources.apply_dpi

-- Default Applications
terminal = "alacritty"
editor = "emacsclient -c"
editor_cmd = editor
browser = "google-chrome-stable"
filemanager = "thunar"
discord = "discord"
launcher = "~/.config/rofi/launchers/text/launcher.sh"
music = terminal .. " --class music -e ncspot"
emoji_launcher = "rofi -show emoji"

-- Global Vars
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"
shift = "Shift"
ctrl = "Control"
