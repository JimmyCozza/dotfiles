local gears = require "gears"

local base_colors = require "src.theme.crylia"
local user_colors = require("src.theme." .. user_vars.colorscheme)

global_colors = (gears.table.join(base_colors, user_colors))

return gears.table.join(global_colors)
