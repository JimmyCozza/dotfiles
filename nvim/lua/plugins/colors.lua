return {
  -- {
  --   "ribru17/bamboo.nvim",
  --   config = function()
  --     require("bamboo").setup({
  --       style = "multiplex",
  --       dim_inactive = true,
  --     })
  --     require("bamboo").load()
  --   end,
  -- },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    -- Optional; default configuration will be used if setup isn't called.
    config = function()
      require("everforest").setup({
        require("everforest").load()
      })
    end,
  }
}
