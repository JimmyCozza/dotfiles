require("nvim-treesitter.configs").setup({
  ensure_installed = { "bash", "csv", "go", "javascript", "json", "lua", "make", "org", "sql", "typescript", "vim" },
  sync_install = false,
  indent = { enable = true },
  highlight = {
    enable = true,
    disable = { "c", "csv" },
    additional_vim_regex_highlighting = { "org" },
  },
})

