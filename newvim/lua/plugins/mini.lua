return {
  {
    "echasnovski/mini.nvim",
    config = function()
      -- Text objects
      require("mini.ai").setup()
      require("mini.surround").setup({
        mappings = {
          delete = "ds",
        },
      })
      require("mini.pairs").setup()
      require("mini.align").setup()

      -- Visual
      require("mini.indentscope").setup()
      require("mini.statusline").setup()
      require("mini.notify").setup()

      -- Search/Navigation
      -- require("mini.files").setup()
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
