local ok, mason = pcall(require, "mason")
if not ok then
  return
end

mason.setup({
    ui = {
        icons = {
          package_installed = "",
          package_pending = "",
          package_uninstalled = "ﮊ",
        }
    }
})

local ok, mason_lsp_config = pcall(require, "mason-lspconfig")
if not ok then
  return
end
mason_lsp_config.setup({
    ensure_installed = { "sumneko_lua", "gopls" }
})
