local icons = require("icons")

return {
  { "ryanoasis/vim-devicons" },
  { "kyazdani42/nvim-web-devicons" },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("nvim-tree").setup({
        actions = {
          use_system_clipboard = false,
        },
        renderer = {
          indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
          icons = {
            glyphs = {
              default = icons.ui.File,
              symlink = icons.ui.FileSymlink,
              bookmark = icons.ui.BookMark,
              modified = icons.git.LineModified,
              folder = {
                arrow_closed = icons.ui.ChevronShortRight,
                arrow_open = icons.ui.ChevronShortDown,
                default = icons.ui.Folder,
                empty = icons.ui.EmptyFolder,
                empty_open = icons.ui.EmptyFolderOpen,
                open = icons.ui.FolderOpen,
                symlink = icons.ui.FolderSymlink,
                symlink_open = icons.ui.FolderOpen,
              },
              git = {
                deleted = icons.git.LineRemoved,
                ignored = icons.git.FileIgnored,
                renamed = icons.git.FileRenamed,
                staged = icons.git.FileStaged,
                unmerged = icons.git.FileUnmerged,
                unstaged = icons.git.FileUnstaged,
                untracked = icons.git.FileUntracked,
              },
            },
          },
        },
      })
    end,
  },
}
