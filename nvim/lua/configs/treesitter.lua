require("nvim-treesitter.configs").setup({
  ensure_installed = { "go", "javascript", "json", "lua", "make", "org", "typescript", "vim" },
  sync_install = false,
  --ignore_install = { "javascript" },
  highlight = {
    enable = true,
    disable = { "c" },
    additional_vim_regex_highlighting = { "org" },
  },
})
