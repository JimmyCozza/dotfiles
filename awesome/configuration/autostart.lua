-- autostart.lua
-- Autostart Stuff Here
local awful = require("awful")

-- Add apps to autostart here
local autostart_apps = {
    "xset -b", -- Disable bell 
    "blueman-applet", -- Bluetooth Systray Applet
    "unclutter --touch" -- Disable cursor when using touch screen
}

for app = 1, #autostart_apps do
    awful.spawn.single_instance(autostart_apps[app], awful.rules.rules)
end

-- Shell applications
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
awful.spawn.with_shell("picom -b --config  $HOME/.config/awesome/picom.conf")

-- EOF ------------------------------------------------------------------------
