return {
  {
    "nvim-orgmode/orgmode",
    event = "VeryLazy",
    config = function()
      require("orgmode").setup({
        org_agenda_files = "~/notes/org/**/*",
        org_default_notes_file = "~/notes/org/refile.org",

        -- Capture templates similar to doom-emacs
        org_capture_templates = {
          t = {
            description = "Task",
            template = "* TODO %?\n %u\n %a", -- Includes link to original location
            target = "~/notes/org/todo.org",
          },
          n = {
            description = "Note",
            template = "* NOTE %?\n %u\n %a",
            target = "~/notes/org/notes.org",
          },
          j = {
            description = "Journal",
            template = "* %<%Y-%m-%d %H:%M> %?\n%a",
            target = "~/notes/org/journal.org",
          },
        },

        -- Global mappings
        mappings = {
          global = {
            -- Doom-like global mappings
            org_agenda = "<leader>oa", -- SPC o a
            org_capture = "<leader>nn", -- SPC X (like doom's capture)
          },
          capture = {
            -- Capture window mappings
            org_capture_finalize = "<leader>mc", -- Complete capture
            org_capture_refile = "<leader>mr", -- Refile capture
            org_capture_kill = "<leader>mk", -- Kill capture
          },
        },

        -- Optional: Configure notification settings
        notifications = {
          enabled = true,
          cron_enabled = false,
          repeater_reminder_time = false,
          deadline_warning_reminder_time = false,
          reminder_time = 10,
          deadline_reminder = true,
          scheduled_reminder = true,
        },
      })

      -- Optional: Add custom keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "org",
        callback = function()
          -- Add org-specific keymaps here
          local opts = { buffer = true, silent = true }
          vim.keymap.set("n", "<CR>", function()
            local line = vim.api.nvim_get_current_line()
            vim.notify(line)
            if line:match("^%*+%s+%w") then
              -- If we're on a headline (starts with * and has content)
              require("orgmode").action("org_todo")
            else
              -- Normal enter behavior
              vim.api.nvim_feedkeys("o", "n", true)
            end
          end, opts)
          vim.keymap.set("n", "<leader>ot", '<cmd>lua require("orgmode").action("org_todo")<CR>', opts)
          vim.keymap.set("n", "<leader>oc", '<cmd>lua require("orgmode").action("org_capture")<CR>', opts)
        end,
      })
    end,
  },
}
