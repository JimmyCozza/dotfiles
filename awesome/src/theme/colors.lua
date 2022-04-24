local gears = require "gears"

local base_colors = require "src.theme.crylia"
local user_colors = require("src.theme." .. user_vars.colorscheme)

return gears.table.join(base_colors, user_colors)
