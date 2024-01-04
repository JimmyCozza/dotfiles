local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  change_detection = {
    enabled = true,
    notify = true,
  },
}

require("lazy").setup({
  { "echasnovski/mini.nvim", version = false },
  { "ryanoasis/vim-devicons" },
  { "kyazdani42/nvim-web-devicons" },
  { "ap/vim-css-color" },
  { "norcalli/nvim-colorizer.lua" },
  { "ellisonleao/gruvbox.nvim" },
  {
    "ribru17/bamboo.nvim",
    config = function()
      require("bamboo").setup({
        style = "multiplex",
        -- transparent = true,
        dim_inactive = true,
      })
      require("bamboo").load()
    end,
  },
  { "shaunsingh/nord.nvim" },
  { "shaunsingh/seoul256.nvim" },
  { "nvim-lua/popup.nvim" },
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim" },
  { "tpope/vim-abolish" },
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-fugitive" },
  { "tpope/vim-endwise" },
  { "mbbill/undotree" },
  { "simnalamburt/vim-mundo" },
  {
    "lewis6991/gitsigns.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  { "nvim-orgmode/orgmode" },
  { "nvim-treesitter/nvim-treesitter" },
  { "nvim-treesitter/playground" },
  { "numToStr/Comment.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "junegunn/vim-easy-align" },
  { "windwp/nvim-autopairs" },
  { "folke/which-key.nvim" },
  { "folke/trouble.nvim" },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "hoob3rt/lualine.nvim" },
  { "gpanders/editorconfig.nvim" },
  { "folke/lsp-colors.nvim" },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "nvim-lua/lsp-status.nvim" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "quangnguyen30192/cmp-nvim-ultisnips" },
  {
    "hrsh7th/nvim-cmp",
    commit = "1cad30fcffa282c0a9199c524c821eadc24bf939", -- This commit is the latest commit before they broke ghost-texthttps://github.com/hrsh7th/nvim-cmp/commit/1cad30fcffa282c0a9199c524c821eadc24bf939  https://github.com/hrsh7th/nvim-cmp/issues/1565
  },
  { "SirVer/ultisnips" },
  { "rafamadriz/friendly-snippets" },
  {
    "fatih/vim-go",
    ft = { "go" },
  },
  { "numtostr/FTerm.nvim" },
  -- {"github/copilot.vim"},
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          filetypes = {
            markdown = true,
          },
        })
      end, 100)
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  { "mfussenegger/nvim-dap" },
  { "leoluz/nvim-dap-go" },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
  },
  { "theHamsta/nvim-dap-virtual-text" },
  { "nvim-telescope/telescope-dap.nvim" },
}, opts)
