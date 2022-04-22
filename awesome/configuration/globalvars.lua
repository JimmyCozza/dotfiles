local awful = require "awful"
local beautiful = require "beautiful"
dpi = beautiful.xresources.apply_dpi

-- Default Applications
terminal = "alacritty"
editor = "emacsclient -c"
editor_cmd = editor
browser = "google-chrome-stable"
filemanager = "thunar"
screenshot = "flameshot gui"
discord = "discord"
launcher = "~/.config/rofi/launchers/text/launcher.sh"
music = terminal .. " --class music -e ncspot"
emoji_launcher = "rofi -show emoji"
notes = "tdrop -ma -w 63% -h 60% -x 2% emacs"

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

local awful = require "awful"
local home = os.getenv "HOME"

-- If you want different default programs, wallpaper path or modkey; edit this file.
user_vars = {
  -- TODO: Add nord & others
  -- gruvbox, catppuccin
  colorscheme = "gruvbox",

  -- Autotiling layouts
  layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
  },

  -- Icon theme from /usr/share/icons
  icon_theme = "Papirus-Dark",

  -- Type 'ip a' and check your wlan and ethernet name
  network = {
    wlan = "wlan0",
    ethernet = "eno1",
  },

  -- Set your font with this format:
  --font = {
  --regular = "JetBrainsMono Nerd Font, 14",
  --bold = "JetBrainsMono Nerd Font, bold 14",
  --extrabold = "JetBrainsMono Nerd Font, ExtraBold 14"
  --},
  font = {
    regular = "Sarasa UI K, 14",
    bold = "Sarasa UI K, bold 14",
    extrabold = "Sarasa UI K, ExtraBold 14",
  },

  -- This is your default Terminal
  terminal = "alacritty",

  -- This is the modkey 'mod4' = Super/Mod/WindowsKey, 'mod3' = alt...
  modkey = "Mod4",

  -- place your wallpaper at this path with this name, you could also try to change the path
  wallpaper = "$HOME/.config/awesome/src/assets/fuji.jpg",

  -- Naming scheme for the powermenu, userhost = "user@hostname", fullname = "Firstname Surname", something else ...
  namestyle = "userhost",

  -- List every Keyboard layout you use here comma seperated. (run localectl list-keymaps to list all averiable keymaps)
  kblayout = { "de", "ru" },

  -- Your filemanager that opens with super+e
  file_manager = "nemo",

  -- Screenshot program to make a screenshot when print is hit
  screenshot_program = "flameshot gui",

  -- If you use the dock here is how you control its size
  dock_icon_size = dpi(50),

  -- Add your programs exactly like in this example.
  -- First entry has to be how you would start the program in the terminal (just try it if you dont know yahoo it)
  -- Second can be what ever the cuss you want it to be (will be the displayed name if you hover over it)
  -- For steam games please use this format (look in .local/share/applications for the .desktop file, that will contain the number you need)
  -- {"394360", "Name", true} true will tell the func that it's a steam game
  -- Use xprop | grep WM_CLASS and use the *SECOND* string
  -- { WM_CLASS, program, name, isSteam }
  dock_programs = {
    { "Alacritty", "alacritty", "Alacritty" },
    { "google-chrome", "google-chrome-stable", "Chrome" },
    { "discord", "discord", "Discord" },
    { "Steam", "steam", "Steams" },
    { "zoom", "zoom", "Zoom" },
  },
}
