return {
  {
    "ThePrimeagen/99",
    config = function()
      local _99 = require("99")

      _99.setup({
        -- Uses OpenCode CLI with Claude Sonnet 4.5 by default
        -- model = "opencode/claude-sonnet-4-5",

        -- Optional: Add AGENT.md files for project context
        -- md_files = { "AGENT.md" },
      })

      -- Fill in function body (cursor inside empty function)
      vim.keymap.set("n", "<leader>9f", function()
        _99.fill_in_function()
      end, { desc = "99: Fill in function" })

      -- Fill in function with custom prompt
      vim.keymap.set("n", "<leader>9F", function()
        _99.fill_in_function_prompt()
      end, { desc = "99: Fill in function (with prompt)" })

      -- Visual selection replacement
      vim.keymap.set("v", "<leader>9v", function()
        _99.visual()
      end, { desc = "99: Visual replace with LLM" })

      -- Visual selection with custom prompt
      vim.keymap.set("v", "<leader>9V", function()
        _99.visual_prompt()
      end, { desc = "99: Visual replace (with prompt)" })

      -- Stop all running requests
      vim.keymap.set("n", "<leader>9s", function()
        _99.stop_all_requests()
      end, { desc = "99: Stop all requests" })

      -- View logs
      vim.keymap.set("n", "<leader>9l", function()
        _99.view_logs()
      end, { desc = "99: View logs" })
    end,
  },
}
