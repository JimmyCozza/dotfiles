local awful = require "awful"

local function focus_next_screen()
  awful.screen.focus_relative(1)
end
local function focus_prev_screen()
  awful.screen.focus_relative(-1)
end

local screen_bindings = {
  {{ modkey, ctrl }, "j", focus_next_screen, "focus the next screen"    },
  {{ modkey, ctrl }, "k", focus_prev_screen, "focus the previous screen"},
}
return setKeys(screen_bindings, "screen")
