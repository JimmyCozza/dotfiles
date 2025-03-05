local helpers = require("helpers")
local map = helpers.map

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
        ensure_installed = { "biome", "clangd", "gopls", "jsonls", "lua_ls", "marksman", "ts_ls" },
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
                ["$HOME/tools/lgi"] = true,
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

      lspconfig.biome.setup({})

      lspconfig.clangd.setup({
        cmd = { "clangd", "--background-index" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        on_attach = on_attach,
      })

      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.marksman.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.zls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "biome" },
        typescript = { "biome" },
        javascriptreact = { "biome" },
        typescriptreact = { "biome" },
        go = { "gofmt" },
        lua = { "stylua" },
      },
      -- Format on save
      format_on_save = {
        -- Timeout for formatting in milliseconds
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      -- Formatter configurations
      formatters = {
        biome = {
          -- Ensure biome respects project configuration
          command = "biome",
          args = { "format", "--stdin-file-path", "$FILENAME" },
          stdin = true,
        },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)

      -- Set up format on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })

      -- Set formatexpr
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
