# Neovim Configuration Migration from Lazy.nvim

This configuration has been migrated from Lazy.nvim to a simpler plugin management system that's ready for the upcoming vim.pack built-in plugin manager.

## Current Setup

The configuration now uses git and Neovim's built-in `packadd` command to manage plugins. This approach:
- Installs plugins in `~/.local/share/nvim/site/pack/plugins/opt/`
- Loads them using `packadd` 
- Maintains compatibility with existing plugin configurations
- Prepares for easy migration to vim.pack when available

## Commands

- `:PluginInstall` - Install all configured plugins
- `:PluginUpdate` - Update all installed plugins

## First Time Setup

1. Open Neovim - plugins will auto-install on first run
2. Restart Neovim after installation completes
3. All plugins should now be loaded and configured

## File Structure

- `lua/config/plugins.lua` - Main plugin list and management functions
- `lua/config/plugin-loader.lua` - Handles loading of Lazy.nvim-formatted configs
- `lua/config/bootstrap.lua` - Auto-installation on first run
- `lua/plugins/*.lua` - Individual plugin configurations (unchanged)

## Migration to vim.pack

When vim.pack becomes available in stable Neovim:

1. Update the `lua/config/plugins.lua` file to use vim.pack API:
   ```lua
   -- Replace M.load() with:
   for _, plugin in ipairs(M.plugins) do
     vim.pack.add(plugin.url, {
       name = plugin.name,
       load = true
     })
   end
   ```

2. Remove the manual git clone logic from `M.install()` and `M.update()`

3. The rest of the configuration will work as-is

## Differences from Lazy.nvim

- No lazy loading (all plugins load at startup)
- No automatic updates (use `:PluginUpdate` manually)
- No UI for plugin management (simple commands only)
- No lockfile (consider git submodules for version locking if needed)

## Rollback

To rollback to Lazy.nvim:
1. Restore `init.lua` to load `require("config.lazy")`
2. Delete the `~/.local/share/nvim/site/pack/plugins/` directory
3. Restart Neovim and let Lazy.nvim reinstall plugins