-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = " "
vim.g.UltiSnipsSnippetDirectories = { os.getenv("HOME") .. "/dotfiles/UltiSnips" }

vim.g.loaded_perl_provider = 0

local opts = {
  clipboard = "unnamedplus",
  cmdheight = 1,
  completeopt = "menu,noselect",
  cursorline = true,
  expandtab = true,
  foldenable = false,
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevel = 10,
  foldmethod = "expr",
  foldnestmax = 10,
  hidden = true,
  ignorecase = true,
  inccommand = "nosplit",
  laststatus = 3,
  mouse = "a",
  number = true,
  relativenumber = false,
  scrolloff = 8,
  shiftwidth = 2,
  smartcase = true,
  softtabstop = 2,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  undofile = true,
  wrap = false,
}

vim.opt.shortmess:append("c")

for k, v in pairs(opts) do
  vim.o[k] = v
end
