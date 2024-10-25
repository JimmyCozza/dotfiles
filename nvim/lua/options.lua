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
  foldlevel = 10,
  foldnestmax = 10,
  hidden = true,
  ignorecase = true,
  inccommand = "nosplit",
  laststatus = 3,
  mouse = "a",
  number = true,
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
