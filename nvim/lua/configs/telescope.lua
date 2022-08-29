local actions = require "telescope.actions"
local trouble = require "trouble.providers.telescope"

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

require("telescope").setup {
  defaults = {
    border = {},
    borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    color_devicons = true,
    dynamic_preview_title = true,
    entry_prefix = "  ",
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
      ".git/*",
    },
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    file_sorter = require("telescope.sorters").get_fzy_sorter,
    generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    initial_mode = "insert",
    layout_config = {
      width = 0.75,
      prompt_position = "bottom",
      preview_cutoff = 120,
      horizontal = { mirror = false },
      vertical = { mirror = false },
    },
    layout_strategy = "horizontal",
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
    path_display = smartTruncate,
    prompt_prefix = " ",
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
    selection_caret = " ",
    selection_strategy = "reset",
    set_env = { ["COLORTERM"] = "truecolor" },
    sorting_strategy = "descending",
    use_less = true,
    winblend = 0,
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
  },
}
