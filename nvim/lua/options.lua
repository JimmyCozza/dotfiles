vim.g.mapleader = " "
vim.g.UltiSnipsSnippetDirectories = { os.getenv("HOME") .. "/dotfiles/UltiSnips" }

vim.g.loaded_perl_provider = 0
vim.g.augment_workspace_folders = { "/home/jimmy/dotfiles/nvim" }

-- somewm creates the wayland-0 socket but never exports WAYLAND_DISPLAY, so
-- Neovim's autodetect falls through to xclip (Xwayland) and yanks land in the
-- wrong clipboard. Pin wl-clipboard explicitly; it falls back to wayland-0.
if vim.fn.executable("wl-copy") == 1 then
  vim.g.clipboard = {
    name = "wl-clipboard",
    copy = {
      ["+"] = "wl-copy",
      ["*"] = "wl-copy --primary",
    },
    paste = {
      ["+"] = "wl-paste --no-newline",
      ["*"] = "wl-paste --no-newline --primary",
    },
    cache_enabled = true,
  }
end

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
