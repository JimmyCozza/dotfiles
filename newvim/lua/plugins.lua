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

local opts = {}
local plugins = {
  -- Style/Visual
  {"ribru17/bamboo.nvim",
    config = function()
      require("bamboo").setup{
        style = "multiplex",
        dim_inactive = true,
      }
    end,
  },

  -- Search/Navigate
  {"nvim-telescope/telescope.nvim"},

  -- Plenary
  {"nvim-lua/plenary.nvim"}
}

require("lazy").setup(plugins, opts)
