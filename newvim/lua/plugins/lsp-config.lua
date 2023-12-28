local helpers = require("helpers")
local map = helpers.map
local appendLabel = helpers.appendLabel
return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "gopls", "jsonls", "lua_ls", "marksman", "tsserver" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
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

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
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

      lspconfig.marksman.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
        },
      })
      vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format)
      appendLabel({ mode = "n", keys = "<Leader>lf", desc = "LSP Format" })
    end,
  },
}
