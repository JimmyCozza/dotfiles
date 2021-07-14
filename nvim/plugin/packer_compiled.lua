-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/jimmy/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ale = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/ale"
  },
  ["auto-pairs"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/auto-pairs"
  },
  ["gruvbox-flat.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/gruvbox-flat.nvim"
  },
  ["gv.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/gv.vim"
  },
  ["javascript-libraries-syntax.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/javascript-libraries-syntax.vim"
  },
  ["limelight.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/limelight.vim"
  },
  ["linediff.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/linediff.vim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  nerdcommenter = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nerdcommenter"
  },
  nerdtree = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nord.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nord.nvim"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["orgmode.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/orgmode.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  ["seoul256.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/seoul256.vim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["trouble.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/trouble.nvim"
  },
  ["typescript-vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/typescript-vim"
  },
  ultisnips = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/ultisnips"
  },
  undotree = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-abolish"
  },
  ["vim-closer"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-closer"
  },
  ["vim-css-color"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-css-color"
  },
  ["vim-dadbod"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-dadbod"
  },
  ["vim-dadbod-ui"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-dadbod-ui"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-devicons"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-go"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/opt/vim-go"
  },
  ["vim-javascript"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-javascript"
  },
  ["vim-jsx"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-jsx"
  },
  ["vim-mundo"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-mundo"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  vimpeccable = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vimpeccable"
  },
  vimwiki = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/vimwiki"
  },
  ["which-key.nvim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/which-key.nvim"
  },
  ["yajs.vim"] = {
    loaded = true,
    path = "/home/jimmy/.local/share/nvim/site/pack/packer/start/yajs.vim"
  }
}

time([[Defining packer_plugins]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType .go ++once lua require("packer.load")({'vim-go'}, { ft = ".go" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/jimmy/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], true)
vim.cmd [[source /home/jimmy/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]]
time([[Sourcing ftdetect script at: /home/jimmy/.local/share/nvim/site/pack/packer/opt/vim-go/ftdetect/gofiletype.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
