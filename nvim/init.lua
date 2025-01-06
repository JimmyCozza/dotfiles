_G.JC = {}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local lazyOpts = {
  ui = {
    border = "rounded",
  },
  change_detection = {
    enabled = true,
    notify = false,
  },
}

require("options")
require("mappings")
require("lazy").setup("plugins", lazyOpts)

--This is just while I deal with some wayland compositor stuff.  For whatever reason, wl-clipboard will hijack my entire window focus without me manually overwriting this.
-- vim.g.clipboard = {
--   name = "wl-clipboard",
--   copy = {
--     ["+"] = "wl-copy --foreground",
--     ["*"] = "wl-copy --foreground",
--     ["x"] = "wl-copy --foreground --primary",
--   },
--   paste = {
--     ["+"] = "wl-paste --foreground",
--     ["*"] = "wl-paste --foreground",
--   },
--   cache_enabled = 0,
-- }

vim.api.nvim_create_autocmd({ "VimEnter" }, {

    command = "Dotenv ~/dotfiles/.env",
})
