local term = require("FTerm.terminal")

local function new_tui(cmd)
  return term:new():setup({
    cmd = cmd,
    dimensions = {
      height = 0.85,
      width = 0.85,
      x = 0.5,
      y = 0.5,
    },
  })
end

function _G.__floating_tui(cmd)
  local tui = new_tui(cmd)
  tui:toggle()
end
