local ok, catppuccin = pcall(require, "catppuccin")
if not ok then
  return
end

catppuccin.setup {
  transparent_background = true,
  term_colors = true,
  styles = {
    comments = "italic",
    functions = "italic",
    keywords = "italic",
    strings = "NONE",
    variables = "italic",
  },
  integrations = {
    cmp = true,
    fern = false,
    gitgutter = false,
    gitsigns = true,
    hop = false,
    indent_blankline = {
      enabled = true,
      colored_indent_levels = false,
    },
    lightspeed = false,
    lsp_trouble = true,
    markdown = true,
    notify = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = "italic",
        hints = "italic",
        warnings = "italic",
        information = "italic",
      },
      underlines = {
        errors = "underline",
        hints = "underline",
        warnings = "underline",
        information = "underline",
      },
    },
    nvimtree = {
      enabled = true,
      show_root = true,
      transparent_panel = true,
    },
    symbols_outline = true,
    telekasten = true,
    telescope = true,
    treesitter = true,
    ts_rainbow = false,
    vim_sneak = false,
    which_key = true,
  },
}
