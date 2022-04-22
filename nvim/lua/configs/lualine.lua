local ok, lualine = pcall(require, "lualine")
if not ok then
  return
end
icon_styles = {
  default = {
    left = "",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
  arrow = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  block = {
    left = " ",
    right = " ",
    main_icon = "   ",
    vi_mode_icon = "  ",
    position_icon = "  ",
  },

  round = {
    left = "",
    right = "",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },

  slant = {
    left = " ",
    right = " ",
    main_icon = "  ",
    vi_mode_icon = " ",
    position_icon = " ",
  },
}

lualine.setup {
  options = {
    always_divide_middle = true,
    component_separators = { left = icon_styles.block.left, right = icon_styles.block.right },
    --component_separators = { left = icon_styles.arrow.position_icon, right = icon_styles.round.left },
    disabled_filetypes = {},
    globalstatus = true,
    icons_enabled = true,
    section_separators = { left = "", right = icon_styles.round.left },
    --section_separators = { left = icon_styles.round.right, right = icon_styles.round.left },
    theme = "gruvbox",
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
}
