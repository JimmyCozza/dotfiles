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

-- local plugins = {
--   -- Style/Visual
--   {"ribru17/bamboo.nvim",
--     config = function()
--       require("bamboo").setup{
--         style = "multiplex",
--         dim_inactive = true,
--       }
--     end,
--   },
--
--   -- Search/Navigate
--   {"nvim-telescope/telescope.nvim",
--     dependencies = { "nvim-lua/plenary.nvim"},
--   },
--   {"folke/trouble.nvim"},
--
--   -- Code
--   {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
--   {"numToStr/Comment.nvim"},
--   { "williamboman/mason.nvim" },
--   { "williamboman/mason-lspconfig.nvim" },
--
--   -- Plenary
--   {"echasnovski/mini.nvim", version = false },
-- }
require("options")
require("mappings")

require("lazy").setup("plugins")
