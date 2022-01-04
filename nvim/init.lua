require "options"
require "plugins"
require "mappings"
require "configs.lualine"
require "lsp"

-- ****************************
-- General Settings
-- ****************************
local global = {
  mapleader = " ",
  nord_contrast = true,
  nord_borders = false,
  nord_disable_background = true,
  nord_italic = true,
  --ale_fixers = {
  --javascript = { "eslint", "prettier" },
  --css = { "eslint" },
  --json = { "prettier" },
  --},
  --ale_fix_on_save = 1,
  --ale_sign_error = '',
  --ale_sign_warning = '--',
  --UltiSnipsSnippetDirectories = { os.getenv('HOME') .. '/dotfiles/UltiSnips' },
}

for k, v in pairs(global) do
  vim.g[k] = v
end

require("nord").set()
