local opts = {
  plugins = {
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
    },
  },
  window = {
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 90,
  },
}

return {
  {
    "folke/which-key.nvim",
    config = function()
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
}
