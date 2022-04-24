-- Statusbar courtesy of @crylia https://github.com/Crylia/crylia-theme

--------------------------------------------------------------------------------------------------------------
-- This is the statusbar, every widget, module and so on is combined to all the stuff you see on the screen --
--------------------------------------------------------------------------------------------------------------
-- Awesome Libs
local awful = require "awful"
local widgets = require "src.widgets"
local dock = require "ui/bar/crylia/dock"
local left_bar = require "ui/bar/crylia/left_bar"
local center_bar = require "ui/bar/crylia/center_bar"
local right_bar = require "ui/bar/crylia/right_bar"

awful.screen.connect_for_each_screen(
  -- For each screen this function is called once
  -- If you want to change the modules per screen use the indices
  -- e.g. 1 would be the primary screen and 2 the secondary screen.
  function(s)
    -- Create 9 tags
    awful.layout.layouts = user_vars.layouts
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, user_vars.layouts[1])

    require "src.modules.powermenu"(s)
    -- TODO: rewrite calendar osd, maybe write an own inplementation
    -- require("src.modules.calendar_osd")(s)
    require "src.modules.volume_osd"(s)
    require "src.modules.brightness_osd"(s)
    require "src.modules.titlebar"

    -- Widgets
    s.battery = widgets.battery()
    s.network = widgets.network()
    s.audio = widgets.audio()
    s.date = widgets.date()
    s.clock = widgets.clock()
    s.bluetooth = widgets.bluetooth()
    s.layoutlist = widgets.layout_list()
    s.powerbutton = widgets.power()
    s.kblayout = widgets.kblayout(s)
    s.taglist = widgets.taglist(s)
    s.tasklist = widgets.tasklist(s)
    s.systray = widgets.systray(s)

    -- Add more of these if statements if you want to change
    -- the modules/widgets per screen.
    -- uncomment this example and dont forget to remove/comment the other code below
    --[[ if s.index == 1 then
            left_bar(s, {s.layoutlist, s.systray, s.taglist})
            center_bar(s, s.tasklist)
            right_bar(s, {s.date, s.clock,s.powerbutton})
            dock(s, user_vars.dock_programs)
        end ]]

    --[[ if s.index == 2 then
            left_bar(s, {s.layoutlist, s.systray, s.taglist})
            center_bar(s, s.tasklist)
            right_bar(s, {s.battery, s.network, s.bluetooth, s.audio, s.kblayout, s.date, s.clock,s.powerbutton})
        end ]]
    -- Bars

    left_bar(s, { s.layoutlist, s.systray, s.taglist })
    -- center_bar(s, s.tasklist)
    right_bar(s, { s.battery, s.network, s.bluetooth, s.audio, s.date, s.clock, s.powerbutton })
    --require("crylia_bar.dock")(s, user_vars.dock_programs)
  end
)
