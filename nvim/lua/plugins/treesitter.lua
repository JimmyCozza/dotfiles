return {
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "csv",
          "go",
          "javascript",
          "json",
          "lua",
          "make",
          "org",
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
          additional_vim_regex_highlighting = { "org" },
        },
      })
    end,
  },
}
