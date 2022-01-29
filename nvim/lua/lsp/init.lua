local lspConfig = require "lspconfig"
require "configs.null-ls"

local settings = {
  tsserver = {},
  gopls = {},
  sumneko_lua = {
    Lua = {
      diagnostics = {
        globals = { "vim", "use" },
      },
    },
  },
}

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<Right>", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
vim.keymap.set("n", "<Left>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)

-- Mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--end
local on_attach = function(client, bufnr)
  if client.name == "tsserver" or client.name == "gopls" then
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
  end
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "tsserver", "sumneko_lua", "gopls" }
for _, server in pairs(servers) do
  lspConfig[server].setup {
    on_attach = on_attach,
    settings = settings[server],
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    },
  }
end
