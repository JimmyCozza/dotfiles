return {
  {
    "ribru17/bamboo.nvim",
    config = function()
      require("bamboo").setup{
        style = "multiplex",
        dim_inactive = true,
      }
    end,
  },
}
