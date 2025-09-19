_G.JC = {}

require("options")
require("mappings")

-- Use new plugin system (prepared for vim.pack migration)
require("config.plugins").setup()

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  command = "Dotenv ~/dotfiles/.env",
})
