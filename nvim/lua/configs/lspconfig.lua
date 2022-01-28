local lspConfig = require "lspconfig"

local custom_settings = {
  sumneko_lua = {
    Lua = {
      diagnostics = {
        globals = { "vim", "use" },
      },
    },
  },
  gopls = {
    settings = {},
    on_attach = function()
    end,
  },
  tsserver = {},
}


--local function on_attach(client)
  --print(vim.inspect(client))
  --vim.notify('attaching to something...')
--end
--require "configs.null-ls"

--lspConfig.sumneko_lua.setup {
  --settings = {
    --Lua = {
  --diagnostics = {
    --globals = { "vim", "use" },
  --},
    --},
  --},
--}
--lspConfig.tsserver.setup {
  --on_attach = function()
    --vim.notify "Attaching to tsserver lsp"
  --end,
--}
--lspConfig.gopls.setup {
  --on_attach = function()
    --vim.notify "Attaching to gopls lsp"
    --vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })
    --vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
    --vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
    --vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0 })
  --end,
--}



-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap("n", "<Right>", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
vim.api.nvim_set_keymap("n", "<Left>", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  vim.notify("Attaching to " .. client.name.. " server.")

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {'tsserver', 'sumneko_lua', 'gopls'}
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    settings = custom_settings[lsp],
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end
