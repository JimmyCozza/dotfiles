return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "csv",
          "go",
          "html",
          "javascript",
          "json",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "sql",
          "typescript",
          "vim",
          "vimdoc",
        },
        sync_install = false,
        indent = { enable = true },
        highlight = {
          enable = true,
          disable = { "c", "csv" },
        },
      })
    end,
  },
}
