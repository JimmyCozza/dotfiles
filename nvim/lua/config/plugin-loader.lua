-- Plugin loader that handles legacy Lazy.nvim configurations
-- This allows gradual migration without rewriting all plugin configs immediately

local M = {}

-- Helper to extract config function from Lazy.nvim format
local function extract_config(module)
  if type(module) == "table" then
    -- Handle array of plugin specs
    for _, spec in ipairs(module) do
      if type(spec) == "table" and spec.config then
        -- Found a config function, execute it
        if type(spec.config) == "function" then
          spec.config()
        end
      elseif type(spec) == "table" and spec.opts then
        -- Handle opts-based configuration
        local plugin_name = spec[1]:match("([^/]+)$"):gsub("%.nvim$", ""):gsub("%.lua$", "")
        local ok, plugin = pcall(require, plugin_name)
        if ok and plugin.setup then
          plugin.setup(spec.opts)
        end
      end
    end
  end
end

-- Load a plugin configuration file
function M.load_plugin_config(name)
  local ok, module = pcall(require, "plugins." .. name)
  if ok then
    extract_config(module)
    return true
  else
    return false, module
  end
end

-- Load all plugin configurations
function M.load_all()
  local configs = {
    "colors",
    "filetree",
    "telescope",
    "treesitter",
    "lsp-config",
    "completion",
    "git",
    "comment",
    "folke",
    "mini",
    "codecompanion",
    "sql",
    "markdown",
    "languages",
  }
  
  for _, config_name in ipairs(configs) do
    local ok, err = M.load_plugin_config(config_name)
    if not ok then
      vim.notify("Failed to load " .. config_name .. ": " .. tostring(err), vim.log.levels.WARN)
    end
  end
end

return M