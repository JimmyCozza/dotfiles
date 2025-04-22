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
          suggestion = {
            auto_trigger = true,
            keymap = {
              accept = false,
              dismiss = "<C-]>",
              next = "<M-]>",
              prev = "<M-[>",
            },
          },
          panel = { enabled = false }, -- Using mini.completion instead
        })

        vim.keymap.set("i", "<Tab>", function()
          if require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          elseif vim.fn.pumvisible() == 1 then
            return vim.api.nvim_replace_termcodes("<C-n>", true, false, true)
          else
            return vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
          end
        end, { expr = true })

        local orig_cr_action = _G.completion_cr_action
        _G.completion_cr_action = function()
          if require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
            return ""
          else
            return orig_cr_action()
          end
        end

        vim.api.nvim_create_autocmd("CompleteChanged", {
          callback = function()
            if require("copilot.suggestion").is_visible() then
              require("copilot.suggestion").dismiss()
            end
          end,
        })
      end, 100)
    end,
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Text objects
      require("mini.ai").setup()
      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          replace = "cs",
        },
      })
      require("mini.pairs").setup()
      require("mini.align").setup()
      require("mini.splitjoin").setup()

      -- Visual
      require("mini.indentscope").setup()
      require("mini.statusline").setup()
      require("mini.notify").setup()
      require("mini.icons").setup()

      -- Completion and Snippets
      require("mini.snippets").setup({
        -- Use <Tab> for both expanding and jumping
        mappings = {
          insert_expand = "<Tab>",
          jump_forward = "<Tab>",
          jump_backward = "<S-Tab>",
        },
      })

      -- Set custom options for mini.completion
      vim.opt.completeopt = "menuone,noselect"
      vim.opt.shortmess:append("c")

      -- Setup mini.completion
      require("mini.completion").setup({
        delay = { completion = 100, info = 100, signature = 50 },
        window = {
          info = { height = 25, width = 80, border = "rounded" },
          signature = { height = 25, width = 80, border = "rounded" },
        },
        lsp_completion = {
          source_func = "omnifunc",
          auto_setup = false, -- We'll set up in LspAttach
        },
        mappings = {
          force_twostep = "<C-Space>",
          force_fallback = "<A-Space>",
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },
      })

      -- Handle Enter key in completion menu
      local keys = vim.keycode and vim.keycode
        or function(x)
          return vim.api.nvim_replace_termcodes(x, true, true, true)
        end

      local cr_keys = {
        ["cr"] = keys("<CR>"),
        ["ctrl-y"] = keys("<C-y>"),
        ["ctrl-y_cr"] = keys("<C-y><CR>"),
      }

      _G.completion_cr_action = function()
        if vim.fn.pumvisible() ~= 0 then
          -- If popup is visible, confirm selected item or add new line otherwise
          local item_selected = vim.fn.complete_info()["selected"] ~= -1
          return item_selected and cr_keys["ctrl-y"] or cr_keys["ctrl-y_cr"]
        else
          -- If popup is not visible, use mini.pairs for CR if available
          return require("mini.pairs") and require("mini.pairs").cr() or cr_keys["cr"]
        end
      end

      -- Set up custom keymappings for completion
      vim.keymap.set("i", "<CR>", "v:lua._G.completion_cr_action()", { expr = true })
      vim.keymap.set("i", "<C-j>", [[pumvisible() ? "\<C-n>" : "\<C-j>"]], { expr = true })
      vim.keymap.set("i", "<C-k>", [[pumvisible() ? "\<C-p>" : "\<C-k>"]], { expr = true })

      -- Search/Navigation
      local miniclue = require("mini.clue")
      miniclue.setup({
        clues = {
          JC.leader_group_clues,
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows({ submode_resize = true }),
          miniclue.gen_clues.z(),
        },
        triggers = {
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          -- mini.basics
          { mode = "n", keys = [[\]] },

          -- mini.bracketed
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
          { mode = "x", keys = "[" },
          { mode = "x", keys = "]" },

          -- Built-in completion
          { mode = "i", keys = "<C-x>" },

          -- `g` key
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          -- Marks
          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          -- Registers
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          -- Window commands
          { mode = "n", keys = "<C-w>" },

          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },
        window = { config = { border = "double" } },
      })
    end,
  },
}
