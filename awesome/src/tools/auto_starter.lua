local awful = require("awful")

local function autostart(table)
  for app = 1, #table do
    awful.spawn.single_instance(table[app], awful.rules.rules)
  end
end

-- Shell applications
awful.spawn.with_shell "~/.config/awesome/autostart.sh"
awful.spawn.with_shell "picom -b --config  $HOME/.config/awesome/picom.conf"

return autostart
