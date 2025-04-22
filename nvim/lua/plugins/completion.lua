return {
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          filetypes = {
            lua = true,
            markdown = true,
            json = true,
            yaml = true,
            zig = true,
            javascript = true,
            typescript = true,
            go = true,
          },
        })
      end, 100)
    end,
  },
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "giuxtaposition/blink-cmp-copilot",
    },
    opts = {
      keymap = {
        preset = "default",
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        documentation = { auto_show = true },
        menu = {
          border = "rounded",
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
            },
          },
        },
        ghost_text = { enabled = true },
        list = {
          selection = {
            preselect = true,
            auto_insert = true,
          },
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer", "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-cmp-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
      signature = { enabled = true },
    },
    config = function(_, opts)
      local icons = require("icons")

      opts.appearance = opts.appearance or {}
      opts.appearance.kind_icons = {
        Text = icons.kind.Text or "󰉿",
        Method = icons.kind.Method or "󰊕",
        Function = icons.kind.Function or "󰊕",
        Constructor = icons.kind.Constructor or "󰒓",
        Field = icons.kind.Field or "󰜢",
        Variable = icons.kind.Variable or "󰆦",
        Class = icons.kind.Class or "󱡠",
        Interface = icons.kind.Interface or "󱡠",
        Module = icons.kind.Module or "󰅩",
        Property = icons.kind.Property or "󰖷",
        Unit = icons.kind.Unit or "󰪚",
        Value = icons.kind.Value or "󰦨",
        Enum = icons.kind.Enum or "󰦨",
        Keyword = icons.kind.Keyword or "󰻾",
        Snippet = icons.kind.Snippet or "󱄽",
        Color = icons.kind.Color or "󰏘",
        File = icons.kind.File or "󰈔",
        Reference = icons.kind.Reference or "󰬲",
        Folder = icons.kind.Folder or "󰉋",
        EnumMember = icons.kind.EnumMember or "󰦨",
        Constant = icons.kind.Constant or "󰏿",
        Struct = icons.kind.Struct or "󱡠",
        Event = icons.kind.Event or "󱐋",
        Operator = icons.kind.Operator or "󰪚",
        TypeParameter = icons.kind.TypeParameter or "󰬛",
      }

      require("blink.cmp").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function()
          if package.loaded["copilot"] and package.loaded["copilot.suggestion"] then
            require("copilot.suggestion").dismiss()
            vim.b.copilot_suggestion_hidden = true
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function()
          vim.b.copilot_suggestion_hidden = false
        end,
      })

      vim.cmd([[ set pumheight=10 ]])
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      for _, server in ipairs({}) do
        if lspconfig[server] then
          lspconfig[server].setup({ capabilities = capabilities })
        end
      end
    end,
  },
}
