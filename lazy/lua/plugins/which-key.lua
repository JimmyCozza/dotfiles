local opts = {}

return {
  {
    "folke/which-key.nvim",
    opts = {
      plugins = {
        presets = {
          operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
        },
      },
      window = {
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 90,
      },
    },
  },
}
