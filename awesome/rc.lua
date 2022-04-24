-----------------------------------------------------------------------------------------
--  █████╗ ██╗    ██╗███████╗███████╗ ██████╗ ███╗   ███╗███████╗██╗    ██╗███╗   ███╗ --
-- ██╔══██╗██║    ██║██╔════╝██╔════╝██╔═══██╗████╗ ████║██╔════╝██║    ██║████╗ ████║ --
-- ███████║██║ █╗ ██║█████╗  ███████╗██║   ██║██╔████╔██║█████╗  ██║ █╗ ██║██╔████╔██║ --
-- ██╔══██║██║███╗██║██╔══╝  ╚════██║██║   ██║██║╚██╔╝██║██╔══╝  ██║███╗██║██║╚██╔╝██║ --
-- ██║  ██║╚███╔███╔╝███████╗███████║╚██████╔╝██║ ╚═╝ ██║███████╗╚███╔███╔╝██║ ╚═╝ ██║ --
-- ╚═╝  ╚═╝ ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝ ╚══╝╚══╝ ╚═╝     ╚═╝ --
-----------------------------------------------------------------------------------------
-- Initialising, order is important!
local awful = require "awful"
require "configuration"
require "src.theme"
require "src.core.error_handling"
require "src.core.rules"
--require "src.core.signals"
require "signals"

require "ui"

-- Shell applications
awful.spawn.with_shell "~/.config/awesome/autostart.sh"
awful.spawn.with_shell "picom -b --config  $HOME/.config/awesome/picom.conf"
awful.spawn.with_shell("feh --bg-fill --randomize ~/Pictures/wallpapers/gruvbox/spaceman.jpg")
--awful.spawn.with_shell("feh --bg-fill --randomize ~/Pictures/wallpapers/" .. user_vars.colorscheme)

-- Garbage Collector Settings
collectgarbage("setpause", 110)
collectgarbage("setstepmul", 1000)
