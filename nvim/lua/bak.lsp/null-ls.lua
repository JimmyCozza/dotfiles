local ok, null_ls = pcall(require, "null-ls")
if not ok then
  return
end

local builtins = null_ls.builtins

null_ls.setup {
  on_attach = function(client)
    if client.resolved_capabilities.document_formatting then
      vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
    end
  end,
  debug = true,
  sources = {
    builtins.formatting.prettier,
    builtins.diagnostics.eslint,
    builtins.formatting.stylua,
  },
}
