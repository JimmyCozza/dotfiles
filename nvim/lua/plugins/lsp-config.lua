local helpers = require("helpers")
local map = helpers.map
local icons = require("icons")

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "biome", "clangd", "gopls", "jsonls", "lua_ls", "marksman", "ts_ls", "prismals" },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
            [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
            [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
            [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
          },
        },
        virtual_text = {
          prefix = icons.ui.Circle,
          source = "if_many",
        },
        float = {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
      })

      local function on_attach(client, bufnr)
        local opts = { buffer = bufnr, remap = false }

        map("n", "gD", vim.lsp.buf.declaration, opts)
        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "gr", vim.lsp.buf.references, opts)
        map("n", "K", vim.lsp.buf.hover, opts)

        map("n", "[d", vim.diagnostic.goto_prev, opts)
        map("n", "]d", vim.diagnostic.goto_next, opts)
        map("n", "<leader>e", vim.diagnostic.open_float, opts)
        map("n", "<leader>q", vim.diagnostic.setloclist, opts)

        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        map("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)

        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, opts)

        if client.server_capabilities.inlayHintProvider then
          map("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, opts)
        end
      end

      local capabilities = require("mini.completion").get_lsp_capabilities()
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
            telemetry = { enable = false },
          },
        },
      })

      lspconfig.jsonls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })

      lspconfig.biome.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.clangd.setup({
        cmd = {
          "clangd",
          "--background-index",
          "--suggest-missing-includes",
          "--clang-tidy",
          "--header-insertion=iwyu",
          "--completion-style=detailed",
          "--function-arg-placeholders",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
        capabilities = capabilities,
        on_attach = on_attach,
      })

      lspconfig.gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      lspconfig.marksman.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.zls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      lspconfig.ts_ls.setup({
        on_attach = function(client, bufnr)
          -- Call the base on_attach function first
          on_attach(client, bufnr)

          -- Add TypeScript specific keymaps
          local opts = { buffer = bufnr, remap = false }
          map("n", "<leader>tR", ":TypescriptRenameFile<CR>", opts)        -- Rename file and update imports
          map("n", "<leader>tI", ":TypescriptOrganizeImports<CR>", opts)   -- Organize imports
          map("n", "<leader>tA", ":TypescriptAddMissingImports<CR>", opts) -- Add missing imports
          map("n", "<leader>tF", ":TypescriptFixAll<CR>", opts)            -- Fix all auto-fixable problems
        end,
        capabilities = capabilities,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
        root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            suggest = {
              completeFunctionCalls = true,
            },
            updateImportsOnFileMove = {
              enabled = "always",
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            suggest = {
              completeFunctionCalls = true,
            },
            updateImportsOnFileMove = {
              enabled = "always",
            },
          },
        },
        commands = {
          TypescriptOrganizeImports = {
            function()
              vim.lsp.buf.execute_command({
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
              })
            end,
            description = "Organize Imports",
          },
          TypescriptRenameFile = {
            function()
              local current_file = vim.api.nvim_buf_get_name(0)
              local target_file = vim.fn.input("New name: ", current_file, "file")
              if target_file ~= "" and target_file ~= current_file then
                vim.lsp.buf.execute_command({
                  command = "_typescript.moveToFile",
                  arguments = { current_file, target_file },
                })
              end
            end,
            description = "Rename File",
          },
          TypescriptAddMissingImports = {
            function()
              vim.lsp.buf.execute_command({
                command = "_typescript.addMissingImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
              })
            end,
            description = "Add Missing Imports",
          },
          TypescriptFixAll = {
            function()
              vim.lsp.buf.execute_command({
                command = "_typescript.fixAll",
                arguments = { vim.api.nvim_buf_get_name(0) },
              })
            end,
            description = "Fix All Auto-fixable Problems",
          },
        },
      })

      lspconfig.prismals.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          -- Set up mini.completion's LSP integration
          vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

          -- Don't enable inlay hints by default, but set up client capability
          -- Use <leader>th to toggle hints when needed
          if client and client.server_capabilities.inlayHintProvider then
            -- vim.lsp.inlay_hint.enable(false, { bufnr = args.buf })
            -- Disabled by default now
          end
        end,
      })
    end,
    dependencies = {
      "b0o/schemastore.nvim",
      "echasnovski/mini.nvim",
    },
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
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters = {
        biome = {
          command = "biome",
          args = { "format", "--stdin-file-path", "$FILENAME" },
          stdin = true,
        },
      },
    },
    config = function(_, opts)
      require("conform").setup(opts)

      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function(args)
          require("conform").format({ bufnr = args.buf })
        end,
      })

      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },
}
