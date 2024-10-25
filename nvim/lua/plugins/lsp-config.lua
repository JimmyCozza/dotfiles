local helpers = require("helpers")
local map = helpers.map

local function eslint_config_exists(bufnr)
  local function find_eslintrc(path)
    local eslint_path = path .. "/.eslintrc.js"
    local f = io.open(eslint_path, "r")
    if f ~= nil then
      io.close(f)
      return true
    end
    local parent = vim.fn.fnamemodify(path, ":h")
    if parent == path then
      return false
    end
    return find_eslintrc(parent)
  end

  local bufname = vim.api.nvim_buf_get_name(bufnr)
  local dir = vim.fn.fnamemodify(bufname, ":h")
  return find_eslintrc(dir)
end

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
        ensure_installed = { "clangd", "gopls", "jsonls", "lua_ls", "marksman", "ts_ls" },
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

      lspconfig.ts_ls.setup({
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
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          require("none-ls.formatting.eslint"),
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                if eslint_config_exists(bufnr) then
                  -- vim.lsp.buf.format({ bufnr = bufnr })
                end
              end,
            })
          end
        end,
      })
      vim.keymap.set("n", "<Leader>lf", vim.lsp.buf.format, { desc = "LSP Format" })
    end,
  },
}
