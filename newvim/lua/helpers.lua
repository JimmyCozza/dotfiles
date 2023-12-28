local M = {}

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


M.leaderMap = function(binding)
  cmd = ""
  opts = binding.opts or {}
  opts.desc = binding.desc

  if string.find(binding.cmd, "<") == 1
  then
    cmd = binding.cmd
  else
    cmd = "<cmd>" .. binding.cmd .. "<cr>"
  end

  M.map(binding.mode, "<Leader>" .. binding.keys, cmd, opts)
end

M.smartTruncate = function(opts, path)
  local pathLength = string.len(path)
  local maxLength = 60
  if pathLength > maxLength then
    local parts = helpers.splitOnSlash(path)
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

return M
