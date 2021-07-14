require('FTerm').setup({
    dimensions  = {
        height = 0.85,
        width = 0.85,
        x = 0.5,
        y = 0.5
    },
    border = 'single'
})

local term = require("FTerm.terminal")

local gitui = term:new():setup({
    cmd = "lazygit",
    dimensions = {
      height = 0.85,
      width = 0.85,
      x = 0.5,
      y = 0.5
    }
})

 -- Use this to toggle gitui in a floating terminal
function _G.__fterm_gitui()
    gitui:toggle()
end
  

