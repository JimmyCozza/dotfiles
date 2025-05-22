return {
  -- { "github/copilot.vim" },
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
          panel = { enabled = false }, -- Using blink.cmp instead
        })
        -- Note: Tab handling is managed by blink.cmp with the super-tab preset
        -- This is just for copilot suggestions
        vim.keymap.set("i", "<Tab>", function()
          if require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          else
            -- Let blink.cmp handle the Tab key
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

      require("mini.indentscope").setup()
      require("mini.statusline").setup()
      require("mini.notify").setup()
      require("mini.icons").setup()

      require("mini.snippets").setup({
        mappings = {
          insert_expand = "<Tab>",
          jump_forward = "<Tab>",
          jump_backward = "<S-Tab>",
        },
      })

      vim.opt.completeopt = "menuone,noselect"
      vim.opt.shortmess:append("c")

      _G.completion_cr_action = function()
        local keys = vim.keycode and vim.keycode
            or function(x)
              return vim.api.nvim_replace_termcodes(x, true, true, true)
            end
        return require("mini.pairs") and require("mini.pairs").cr() or keys("<CR>")
      end

      vim.keymap.set("i", "<CR>", "v:lua._G.completion_cr_action()", { expr = true })

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
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },

          { mode = "n", keys = [[\]] },

          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
          { mode = "x", keys = "[" },
          { mode = "x", keys = "]" },

          { mode = "i", keys = "<C-x>" },

          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },

          { mode = "n", keys = "'" },
          { mode = "n", keys = "`" },
          { mode = "x", keys = "'" },
          { mode = "x", keys = "`" },

          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-r>" },
          { mode = "c", keys = "<C-r>" },

          { mode = "n", keys = "<C-w>" },

          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },
        window = { config = { border = "double" } },
      })
    end,
  },
}
