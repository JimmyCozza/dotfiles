local awful = require "awful"

local function raise_volume()
    awful.spawn "pamixer -i 3"
    awesome.emit_signal("widget::volume")
    awesome.emit_signal("module::volume_osd:show", true)
    awesome.emit_signal("module::slider:update")
    awesome.emit_signal("widget::volume_osd:rerun")
end

local function lower_volume()
    awful.spawn "pamixer -d 3"
    awesome.emit_signal("widget::volume")
    awesome.emit_signal("module::volume_osd:show", true)
    awesome.emit_signal("module::slider:update")
    awesome.emit_signal("widget::volume_osd:rerun")
end

local function mute()
    awful.spawn "pamixer -t"
    awesome.emit_signal("widget::volume")
    awesome.emit_signal("module::volume_osd:show", true)
    awesome.emit_signal("module::slider:update")
    awesome.emit_signal("widget::volume_osd:rerun")
end

local function open_pavucontrol()
    awful.spawn "pavucontrol"
end

local function play_pause()
  awful.spawn "playerctl play-pause"
end

local function next_track()
  awful.spawn "playerctl next"
end

local function prev_track()
  awful.spawn "playerctl previous"
end

local media_keys = {
  {{},         "XF86AudioRaiseVolume", raise_volume,     "increase volume"   },
  {{},         "XF86AudioLowerVolume", lower_volume,     "decrease volume"   },
  {{},         "XF86AudioMute",        mute,             "mute volume"       },
  {{},         "XF86AudioPlay",        play_pause,       "toggle playerctl"  },
  {{},         "XF86AudioPrev",        prev_track,       "playerctl previous"},
  {{},         "XF86AudioNext",        next_track,       "playerctl next"    },
  {{ modkey }, "v",                    open_pavucontrol, "open pavucontrol"  },
}

return setKeys(media_keys, "media")
