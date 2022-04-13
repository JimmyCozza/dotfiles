local awful = require "awful"

local media = {
  -- Volume control
  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn "pamixer -i 3"
  end, { description = "increase volume", group = "media" }),
  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn "pamixer -d 3"
  end, { description = "decrease volume", group = "media" }),
  awful.key({}, "XF86AudioMute", function()
    awful.spawn "pamixer -t"
  end, { description = "mute volume", group = "media" }),
  awful.key({ modkey }, "v", function()
    awful.spawn "pavucontrol"
  end, { description = "open pavucontrol", group = "media" }),
  -- Media Control
  awful.key({}, "XF86AudioPlay", function()
    awful.spawn "playerctl play-pause"
  end, { description = "toggle playerctl", group = "media" }),
  awful.key({}, "XF86AudioPrev", function()
    awful.spawn "playerctl previous"
  end, { description = "playerctl previous", group = "media" }),
  awful.key({}, "XF86AudioNext", function()
    awful.spawn "playerctl next"
  end, { description = "playerctl next", group = "media" }),
}

return media
