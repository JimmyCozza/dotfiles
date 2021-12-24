local opts = {
  cmdheight     = 1,
  number        = true,
  wrap          = false,
  tabstop       = 2,
  softtabstop   = 2,
  shiftwidth    = 2,
  hidden        = true,
  expandtab     = true,
  ignorecase    = true,
  smartcase     = true,
  clipboard     = 'unnamedplus',
  cursorline    = true,
  inccommand    = 'nosplit',
  mouse         = 'a',
  swapfile      = false,
  undofile      = true,
  completeopt   = 'menu,noselect',
  splitbelow    = true,
  splitright    = true,
  termguicolors = true,
  scrolloff     = 8,

}

vim.opt.shortmess:append "c"

for k, v in pairs(opts) do
  vim.o[k] = v
end

