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

local lazygit = term:new():setup({
    cmd = "lazygit",
    dimensions = {
      height = 0.85,
      width = 0.85,
      x = 0.5,
      y = 0.5
    }
})

local lazydocker = term:new():setup({
    cmd = "lazydocker",
    dimensions = {
      height = 0.85,
      width = 0.85,
      x = 0.5,
      y = 0.5
    }
})

local bpytop = term:new():setup({
    cmd = "bpytop",
    dimensions = {
      height = 0.85,
      width = 0.85,
      x = 0.5,
      y = 0.5
    }
})

function _G.__fterm_lazygit()
    lazygit:toggle()
end
function _G.__fterm_lazydocker()
    lazydocker:toggle()
end
function _G.__fterm_bpytop()
    bpytop:toggle()
end

