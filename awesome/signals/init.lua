-- Awesome Libs
local awful = require "awful"
local naughty = require "naughty"
local beautiful = require "beautiful"

local sh = require "signals.helpers"

local function connect_signals(signals, type)
  for _, signal in ipairs(signals) do
    type.connect_signal(signal[1], signal[2])
  end
end


local screen_signals = {
  { "added", awesome.restart },
  { "removed", awesome.restart },
}

local client_signals = {
  { "manage", sh.manage_client },
  { "unmanage", sh.unmanage_client },
  { "tag::switched", sh.switch_tags },
  { "focus", sh.apply_border_color },
  { "unfocus", sh.reset_border_color },
}

local widget_signals = {

}

connect_signals(screen_signals, screen)
connect_signals(client_signals, client)
--connect_signals(client_signals, client)
-- Workaround for focused border color, why in the love of god doesnt it work with
-- beautiful.border_focus
--client.connect_signal("focus", function(c)
  --c.border_color = "#616161"
--end)

client.connect_signal("unfocus", function(c)
  c.border_color = beautiful.border_normal
end)

--function Hover_signal(widget, bg, fg)
  --local old_wibox, old_cursor, old_bg, old_fg
  --widget:connect_signal("mouse::enter", function()
    --if bg then
      --old_bg = widget.bg
      --if string.len(bg) == 7 then
        --widget.bg = bg .. "dd"
      --else
        --widget.bg = bg
      --end
    --end
    --if fg then
      --old_fg = widget.fg
      --widget.fg = fg
    --end
    --local w = mouse.current_wibox
    --if w then
      --old_cursor, old_wibox = w.cursor, w
      --w.cursor = "hand1"
    --end
  --end)

  --widget:connect_signal("button::press", function()
    --if bg then
      --if bg then
        --if string.len(bg) == 7 then
          --widget.bg = bg .. "bb"
        --else
          --widget.bg = bg
        --end
      --end
    --end
    --if fg then
      --widget.fg = fg
    --end
  --end)

  --widget:connect_signal("button::release", function()
    --if bg then
      --if bg then
        --if string.len(bg) == 7 then
          --widget.bg = bg .. "dd"
        --else
          --widget.bg = bg
        --end
      --end
    --end
    --if fg then
      --widget.fg = fg
    --end
  --end)

  --widget:connect_signal("mouse::leave", function()
    --if bg then
      --widget.bg = old_bg
    --end
    --if fg then
      --widget.fg = old_fg
    --end
    --if old_wibox then
      --old_wibox.cursor = old_cursor
      --old_wibox = nil
    --end
  --end)
--end

