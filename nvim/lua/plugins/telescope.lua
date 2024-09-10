local helpers = require("helpers")

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local actions = require("telescope.actions")
      local trouble = require("trouble.sources.telescope")
      require("telescope").setup({
        defaults = {
          find_command = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--trim",
          },
          file_ignore_patterns = {
            ".git/.*",
          },
          path_display = helpers.smartTruncate,
          mappings = {
            i = {
              ["<C-c>"] = actions.close,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<C-t>"] = trouble.open,
              ["<CR>"] = actions.select_default + actions.center,
            },
            n = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
              ["<C-t>"] = trouble.open,
              ["?"] = actions.which_key,
            },
          },
        },
      })
    end,
  },
}
