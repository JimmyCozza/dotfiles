return {
  {
    "stevearc/dressing.nvim",
    opts = {},
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          -- inline = {
          --   adapter = "anthropic",
          -- },
        },
      })
    end,
  },
}
