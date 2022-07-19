local present, lspconfig = pcall(require, "lspconfig")
local set_lsp_mappings = require "lsp.mappings"
local lsp_handlers = require "lsp.handlers"
require "lsp.lsp_installer"

if not present then
  return
end

local M = {}

lsp_handlers()

function M.on_attach(client, _)
  set_lsp_mappings()
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lspconfig.sumneko_lua.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "use", "awesome", "screen" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
}

lspconfig.gopls.setup {
  on_attach = M.on_attach,
  capabilities = capabilities,
}

return M
