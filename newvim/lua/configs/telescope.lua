local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

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

require("telescope").setup({
  defaults = {
    path_display = smartTruncate,
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
    }
  },
})
