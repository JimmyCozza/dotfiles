return {
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      preset = 'super-tab',

      window = {
        border = "rounded",
      },

      experimental = {
        ghost_text = true,
      },
    },
  },
}

