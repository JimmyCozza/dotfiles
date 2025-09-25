local icons = require("icons")

return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "echasnovski/mini.nvim",
    },
    config = function()
      require("nvim-tree").setup({
        actions = {
          use_system_clipboard = false,
        },
        renderer = {
          indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
        },
      })
    end,
  },
}