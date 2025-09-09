return {
  -- { "github/copilot.vim" }, -- Keeping for auth only
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "nvim-mini/mini.nvim",
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
