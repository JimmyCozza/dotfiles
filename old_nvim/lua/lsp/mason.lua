local ok, mason = pcall(require, "mason")
if not ok then
  return
end

local icons = require("icons")

mason.setup({
  ui = {
    icons = {
      package_installed = icons.git.LineAdded,
      package_pending = icons.git.LineModified,
      package_uninstalled = icons.git.FileDeleted,
    },
  },
})

local ok, mason_lsp_config = pcall(require, "mason-lspconfig")
if not ok then
  return
end
mason_lsp_config.setup({
  ensure_installed = { "gopls", "tsserver" },
})
