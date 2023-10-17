local M = {}
M.map = function(mode, keys, command, opt)
  local options = { silent = true }

  if opt then
    options = vim.tbl_extend("force", options, opt)
  end

  if type(keys) == "table" then
    for _, keymap in ipairs(keys) do
      M.map(mode, keymap, command, opt)
    end
    return
  end

  vim.keymap.set(mode, keys, command, opt)
end

M.del = function()
  vim.keymap.del()
end

M.split = function(inputStr, pattern)
  local parts = {}
  for part in string.gmatch(inputStr, pattern) do
    table.insert(parts, part)
  end
  return parts
end

M.splitOnSlash = function(inputStr)
  return M.split(inputStr, "([^/]+)")
end

return M
