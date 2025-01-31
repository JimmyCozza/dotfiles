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
    keys = {
      { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout Branch" },
      { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout Commit" },
      { "<leader>gC", "<cmd>Telescope git_bcommits<cr>", desc = "Checkout Commit (Current file)" },
      { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Git Status" },
      { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
      { "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
      { "<leader>pb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
      { "<leader>pf", "<cmd>Telescope find_files<cr>", desc = "Find Files in Project" },
      { "<leader>ps", "<cmd>Telescope grep_string<cr>", desc = "Search in Project" },
      -- This one depends on what grep_cmd is, but assuming it's telescope live_grep:
      { "<leader>sc", "<cmd>nohlsearch<cr>", desc = "Clear Search Highlighting" },
    },
  },
}
