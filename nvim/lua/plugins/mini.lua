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
      
      -- Comment functionality (replacing Comment.nvim)
      require("mini.comment").setup({
        options = {
          custom_commentstring = nil,
          ignore_blank_line = false,
          start_of_line = false,
          pad_comment_parts = true,
        },
        mappings = {
          comment = 'gc',
          comment_line = 'gcc',
          comment_visual = 'gc',
          textobject = 'gc',
        },
      })
      
      -- Highlight patterns (replacing todo-comments.nvim)
      require("mini.hipatterns").setup({
        highlighters = {
          -- Highlight TODO, FIXME, HACK, NOTE, etc.
          fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
          todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
          note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
          
          -- Highlight hex color strings
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
      })

      require("mini.indentscope").setup()
      require("mini.statusline").setup()
      require("mini.notify").setup()
      require("mini.icons").setup()
      
      -- Git integration (replacing gitsigns.nvim)
      require("mini.diff").setup({
        view = {
          style = 'sign',  -- 'sign' or 'number'
          signs = { add = '+', change = '~', delete = '-' },
        },
        mappings = {
          -- Apply hunks
          apply = 'gh',
          reset = 'gH',
          
          -- Navigation
          goto_first = '[H',
          goto_prev = '[h',
          goto_next = ']h',
          goto_last = ']H',
          
          -- Textobject
          textobject = 'gh',
        },
      })
      
      require("mini.git").setup({
        -- General CLI execution
        command = {
          split = 'horizontal',  -- or 'vertical', 'tab'
        },
      })
      
      -- File explorer (replacing nvim-tree.lua)
      require("mini.files").setup({
        mappings = {
          close       = 'q',
          go_in       = 'l',
          go_in_plus  = '<CR>',
          go_out      = 'h',
          go_out_plus = '-',
          reset       = '<BS>',
          reveal_cwd  = '@',
          show_help   = 'g?',
          synchronize = '=',
          trim_left   = '<',
          trim_right  = '>',
        },
        windows = {
          preview = true,
          width_focus = 30,
          width_nofocus = 15,
          width_preview = 50,
        },
        options = {
          permanent_delete = false,
          use_as_default_explorer = false,  -- Keep false to not conflict with netrw
        },
      })

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
