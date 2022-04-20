local awful = require "awful"
local hotkeys_popup = require "awful.hotkeys_popup"
local beautiful = require "beautiful"
-- Create a launcher widget and a main menu
local awesomemenu = {
  {
    "Key Binds",
    function()
      hotkeys_popup.show_help(nil, awful.screen.focused())
    end,
  },
  { "Manual", terminal .. " start man awesome" },
  { "Edit Config", editor .. " " .. awesome.conffile },
  { "Restart", awesome.restart },
  {
    "Quit",
    function()
      awesome.quit()
    end,
  },
}

local appmenu = { { "Alacritty", terminal }, { "Emacs", editor } }

local mymainmenu = awful.menu {
  items = {
    { "AwesomeWM", awesomemenu, beautiful.awesome_icon },
    { "Apps", appmenu },
  },
}

return mymainmenu
