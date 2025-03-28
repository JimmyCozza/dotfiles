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

M.smartTruncate = function(opts, path)
  local pathLength = string.len(path)
  local maxLength = 60
  if pathLength > maxLength then
    local parts = M.splitOnSlash(path)
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

-- --------------------------------
-- Key mapping functions
-- --------------------------------

M.map = function(mode, lhs, rhs, opts)
  -- Set default options
  opts = opts or { silent = true, noremap = true }

  if type(lhs) == "table" then
    for _, keymap in ipairs(lhs) do
      M.map(mode, keymap, rhs, opts)
    end
    return
  end

  vim.keymap.set(mode, lhs, rhs, opts)
end

_G.Keymap = _G.Keymap or {
  groups = {},
  mappings = {},
}

M.group = function(prefix, name)
  if not prefix:match("^<Leader>") and not prefix:match("^g") then
    prefix = "<Leader>" .. prefix
  end

  Keymap.groups[prefix] = name
  return prefix
end

M.lmap = function(mode, keys, command, desc, opts)
  opts = opts or {}
  opts.desc = desc

  table.insert(Keymap.mappings, {
    mode = mode,
    keys = "<Leader>" .. keys,
    command = command,
    desc = desc,
  })

  local rhs
  if type(command) == "string" then
    if command:match("^<") then
      rhs = command
    elseif command:match("^:") then
      rhs = command .. "<CR>"
    else
      rhs = "<cmd>" .. command .. "<CR>"
    end
  else
    rhs = command
  end

  M.map(mode, "<Leader>" .. keys, rhs, opts)
end

M.init_which_key = function()
  local clues = {}

  for prefix, name in pairs(Keymap.groups) do
    table.insert(clues, {
      mode = "n",
      keys = prefix,
      desc = name,
    })
  end

  if _G.JC and _G.JC.leader_group_clues then
    _G.JC.leader_group_clues = clues
  end

  return clues
end

M.map_group = function(mappings)
  for _, mapping in ipairs(mappings) do
    if #mapping == 3 then
      M.lmap("n", mapping[1], mapping[2], mapping[3])
    else
      M.lmap(mapping.mode or "n", mapping.keys, mapping.cmd, mapping.desc, mapping.opts)
    end
  end
end

return M
