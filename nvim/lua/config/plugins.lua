-- Plugin management configuration
-- Prepared for migration to vim.pack once available
-- Currently using git submodules and packadd

local M = {}

-- Plugin list with configurations
M.plugins = {
  -- Plenary (dependency for many plugins)
  {
    url = "nvim-lua/plenary.nvim",
    name = "plenary.nvim",
  },

  -- UI & Icons
  {
    url = "nvim-tree/nvim-web-devicons",
    name = "nvim-web-devicons",
  },
  {
    url = "MunifTanjim/nui.nvim",
    name = "nui.nvim",
  },
  {
    url = "stevearc/dressing.nvim",
    name = "dressing.nvim",
  },

  -- Colorscheme
  {
    url = "neanias/everforest-nvim",
    name = "everforest-nvim",
  },

  -- File explorer
  {
    url = "nvim-tree/nvim-tree.lua",
    name = "nvim-tree.lua",
  },

  -- Telescope
  {
    url = "nvim-telescope/telescope.nvim",
    name = "telescope.nvim",
  },

  -- Treesitter
  {
    url = "nvim-treesitter/nvim-treesitter",
    name = "nvim-treesitter",
  },
  {
    url = "nvim-treesitter/nvim-treesitter-textobjects",
    name = "nvim-treesitter-textobjects",
  },

  -- LSP
  {
    url = "neovim/nvim-lspconfig",
    name = "nvim-lspconfig",
  },
  {
    url = "williamboman/mason.nvim",
    name = "mason.nvim",
  },
  {
    url = "williamboman/mason-lspconfig.nvim",
    name = "mason-lspconfig.nvim",
  },
  {
    url = "b0o/schemastore.nvim",
    name = "schemastore.nvim",
  },

  -- Formatting
  {
    url = "stevearc/conform.nvim",
    name = "conform.nvim",
  },

  -- Completion
  {
    url = "hrsh7th/nvim-cmp",
    name = "nvim-cmp",
  },
  {
    url = "hrsh7th/cmp-nvim-lsp",
    name = "cmp-nvim-lsp",
  },
  {
    url = "hrsh7th/cmp-buffer",
    name = "cmp-buffer",
  },
  {
    url = "hrsh7th/cmp-path",
    name = "cmp-path",
  },
  {
    url = "hrsh7th/cmp-cmdline",
    name = "cmp-cmdline",
  },
  {
    url = "hrsh7th/cmp-nvim-lua",
    name = "cmp-nvim-lua",
  },

  -- Snippets
  {
    url = "SirVer/ultisnips",
    name = "ultisnips",
  },
  {
    url = "quangnguyen30192/cmp-nvim-ultisnips",
    name = "cmp-nvim-ultisnips",
  },

  -- Git
  {
    url = "tpope/vim-fugitive",
    name = "vim-fugitive",
  },
  {
    url = "lewis6991/gitsigns.nvim",
    name = "gitsigns.nvim",
  },
  {
    url = "tpope/vim-rhubarb",
    name = "vim-rhubarb",
  },
  {
    url = "sindrets/diffview.nvim",
    name = "diffview.nvim",
  },

  -- Comments (now handled by mini.comment)

  -- Folke plugins
  {
    url = "folke/trouble.nvim",
    name = "trouble.nvim",
  },
  -- todo-comments replaced with mini.hipatterns
  {
    url = "folke/noice.nvim",
    name = "noice.nvim",
  },

  -- Mini.nvim
  {
    url = "echasnovski/mini.nvim",
    name = "mini.nvim",
  },

  -- AI
  {
    url = "zbirenbaum/copilot.lua",
    name = "copilot.lua",
  },
  {
    url = "zbirenbaum/copilot-cmp",
    name = "copilot-cmp",
  },
  {
    url = "olimorris/codecompanion.nvim",
    name = "codecompanion.nvim",
  },

  -- Database
  {
    url = "tpope/vim-dadbod",
    name = "vim-dadbod",
  },
  {
    url = "kristijanhusak/vim-dadbod-ui",
    name = "vim-dadbod-ui",
  },
  {
    url = "kristijanhusak/vim-dadbod-completion",
    name = "vim-dadbod-completion",
  },

  -- Language specific
  {
    url = "fatih/vim-go",
    name = "vim-go",
  },

  -- Markdown
  {
    url = "OXY2DEV/markview.nvim",
    name = "markview.nvim",
  },

  -- Other utilities
  {
    url = "tpope/vim-dotenv",
    name = "vim-dotenv",
  },
}

-- Installation function (to be called manually or automated)
function M.install()
  local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins"
  local opt_path = pack_path .. "/opt"
  
  -- Create directories if they don't exist
  vim.fn.mkdir(opt_path, "p")
  
  for _, plugin in ipairs(M.plugins) do
    local plugin_path = opt_path .. "/" .. plugin.name
    if vim.fn.isdirectory(plugin_path) == 0 then
      print("Installing " .. plugin.name .. "...")
      local url = "https://github.com/" .. plugin.url
      vim.fn.system({"git", "clone", "--depth", "1", url, plugin_path})
    end
  end
  
  print("Installation complete. Restart Neovim to load plugins.")
end

-- Update function
function M.update()
  local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins"
  local opt_path = pack_path .. "/opt"
  
  for _, plugin in ipairs(M.plugins) do
    local plugin_path = opt_path .. "/" .. plugin.name
    if vim.fn.isdirectory(plugin_path) == 1 then
      print("Updating " .. plugin.name .. "...")
      vim.fn.system({"git", "-C", plugin_path, "pull"})
    end
  end
  
  print("Update complete. Restart Neovim to load updated plugins.")
end

-- Generate helptags for all plugins
function M.generate_helptags()
  local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/opt"
  local generated = {}
  
  for _, plugin in ipairs(M.plugins) do
    local doc_path = pack_path .. "/" .. plugin.name .. "/doc"
    if vim.fn.isdirectory(doc_path) == 1 then
      -- Check if there are any .txt files in the doc directory
      local txt_files = vim.fn.glob(doc_path .. "/*.txt", false, true)
      if #txt_files > 0 then
        vim.cmd("silent! helptags " .. vim.fn.fnameescape(doc_path))
        table.insert(generated, plugin.name)
      end
    end
  end
  
  if #generated > 0 then
    print("Generated helptags for " .. #generated .. " plugins")
  end
  
  return generated
end

-- Load all plugins
function M.load()
  local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/opt"
  
  for _, plugin in ipairs(M.plugins) do
    local plugin_path = pack_path .. "/" .. plugin.name
    if vim.fn.isdirectory(plugin_path) == 1 then
      vim.cmd("packadd " .. plugin.name)
    end
  end
end

-- Setup function to initialize plugin configurations
function M.setup()
  -- Check if plugins are installed
  local pack_path = vim.fn.stdpath("data") .. "/site/pack/plugins/opt"
  local needs_install = false
  
  if vim.fn.isdirectory(pack_path) == 0 then
    needs_install = true
  else
    -- Check if at least some key plugins exist
    local test_plugin = pack_path .. "/plenary.nvim"
    if vim.fn.isdirectory(test_plugin) == 0 then
      needs_install = true
    end
  end
  
  if needs_install then
    print("First time setup: Installing plugins...")
    print("This may take a minute...")
    M.install()
    print("\nPlugins installed! Please restart Neovim.")
    return
  end
  
  -- Load all plugins first
  M.load()
  
  -- Generate helptags for all plugins
  M.generate_helptags()
  
  -- Load plugin configurations using the loader
  -- This handles the Lazy.nvim format automatically
  require("config.plugin-loader").load_all()
end

-- Future vim.pack migration helper
-- When vim.pack becomes available, this function will help migrate
function M.prepare_for_vim_pack()
  local migration_code = [[
-- Future vim.pack configuration
-- Uncomment when vim.pack is available in stable Neovim

for _, plugin in ipairs(M.plugins) do
  vim.pack.add(plugin.url, {
    name = plugin.name,
    load = true
  })
end
]]
  return migration_code
end

-- Commands for plugin management
vim.api.nvim_create_user_command("PluginInstall", M.install, {})
vim.api.nvim_create_user_command("PluginUpdate", M.update, {})
vim.api.nvim_create_user_command("PluginHelptags", function()
  local generated = M.generate_helptags()
  if #generated > 0 then
    print("Regenerated helptags for: " .. table.concat(generated, ", "))
  else
    print("No plugin documentation found to generate helptags")
  end
end, {})

return M