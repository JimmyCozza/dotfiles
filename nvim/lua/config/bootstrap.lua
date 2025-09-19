-- Bootstrap script for plugin installation
-- Run this the first time to install all plugins

local M = {}

function M.setup()
  print("=== Neovim Plugin Bootstrap ===")
  print("Setting up plugin management without Lazy.nvim")
  print("")
  
  -- Install plugins
  print("Installing plugins...")
  require("config.plugins").install()
  
  print("")
  print("=== Setup Complete ===")
  print("Restart Neovim to load the installed plugins.")
  print("Use :PluginUpdate to update plugins in the future.")
end

-- Auto-bootstrap on first run
local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/opt"
if vim.fn.isdirectory(pack_path) == 0 then
  M.setup()
end

return M