local present, lspconfig = pcall(require, "lspconfig")
local lsp_handlers = require("lsp.handlers")
local map = require("helpers").map
require("lsp.mason")

if not present then
  return
end

lsp_handlers()

local function on_attach(client, bufnr)
  local opts = { buffer = bufnr, remap = false }
  map("n", "gD", vim.lsp.buf.declaration, opts)
  map("n", "gd", vim.lsp.buf.definition, opts)
  map("n", "K", vim.lsp.buf.hover, opts)
  map("n", "gi", vim.lsp.buf.implementation, opts)
  map("n", "gr", vim.lsp.buf.references, opts)
  map("n", "[d", vim.diagnostic.goto_prev, opts)
  map("n", "d]", vim.diagnostic.goto_next, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

lspconfig.sumneko_lua.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim", "use", "awesome", "screen" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          ["/usr/local/share/awesome/lib"] = true,
        },
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})
