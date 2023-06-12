local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
local Util = require("lazyvim.util")

-- Split on / character:
--   local parts = utils.split(path, '([^/]+)')
local function split(inputStr, pattern)
  local parts = {}
  for part in string.gmatch(inputStr, pattern) do
    table.insert(parts, part)
  end
  return parts
end

local function splitOnSlash(inputStr)
  return split(inputStr, "([^/]+)")
end

local function smartTruncate(opts, path)
  local pathLength = string.len(path)
  local maxLength = 60
  if pathLength > maxLength then
    local parts = splitOnSlash(path)
    local letters = {}
    for index, value in ipairs(parts) do
      local shifted = { unpack(parts, index + 1) }
      local short = table.concat(shifted, "/")
      table.insert(letters, string.sub(value, 1, 1))
      local smartShortPath = table.concat(letters, "/") .. "/" .. short
      if string.len(smartShortPath) < maxLength then
        return smartShortPath
      end
    end
  end
  return path
end

return {
  "nvim-telescope/telescope.nvim",
  commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  keys = {
    { "<leader>,", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>/", Util.telescope("live_grep"), desc = "Grep (root dir)" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader><space>", Util.telescope("files"), desc = "Find Files (root dir)" },
    -- git
    { "<leader>gb", "<cmd>Telescope git_branches<CR>", desc = "Checkout Branch" },
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
    -- help
    { "<leader>hh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>hH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>hm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    -- project
    { "<leader>pb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>pf", Util.telescope("files"), desc = "Find Files (root dir)" },
    { "<leader>pF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
    { "<leader>pr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>pR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
    -- search
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>nohlsearch<cr>", desc = "Clear Search Highlighting" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
    { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
    { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    { "<leader>sw", Util.telescope("grep_string"), desc = "Word (root dir)" },
    { "<leader>sW", Util.telescope("grep_string", { cwd = false }), desc = "Word (cwd)" },
    { "<leader>uC", Util.telescope("colorscheme", { enable_preview = true }), desc = "Colorscheme with preview" },
    {
      "<leader>ss",
      Util.telescope("lsp_document_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol",
    },
    {
      "<leader>sS",
      Util.telescope("lsp_dynamic_workspace_symbols", {
        symbols = {
          "Class",
          "Function",
          "Method",
          "Constructor",
          "Interface",
          "Module",
          "Struct",
          "Trait",
          "Field",
          "Property",
        },
      }),
      desc = "Goto Symbol (Workspace)",
    },
  },
  opts = {
    defaults = {
      path_display = smartTruncate,
      prompt_prefix = " ",
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      selection_caret = " ",
      selection_strategy = "reset",
      mappings = {
        i = {
          ["<C-c>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<C-t>"] = trouble.open_with_trouble,
          ["<CR>"] = actions.select_default + actions.center,
        },
        n = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          ["<C-t>"] = trouble.open_with_trouble,
          ["?"] = actions.which_key,
        },
      },
    },
  },
}
