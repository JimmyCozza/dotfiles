_G.JC = {}

require("options")
require("mappings")
require("config.lazy")

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  command = "Dotenv ~/dotfiles/.env",
})
