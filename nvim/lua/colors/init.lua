-- Colorschemes
-- require("mini.base16").setup({
--   palette = {
--     base00 = "#1d2021", --  ----
--     base01 = "#3c3836", --  ---
--     base02 = "#504945", --  --
--     base03 = "#665c54", --  -
--     base04 = "#bdae93", --  +
--     base05 = "#d5c4a1", --  ++
--     base06 = "#ebdbb2", --  +++
--     base07 = "#fbf1c7", --  ++++
--     base08 = "#fb4934", --  red
--     base09 = "#fe8019", --  orange
--     base0A = "#fabd2f", --  yellow
--     base0B = "#b8bb26", --  green
--     base0C = "#8ec07c", --  aqua/cyan
--     base0D = "#83a598", --  blue
--     base0E = "#d3869b", --  purple
--     base0F = "#d65d0e", --  brown
--   },
-- })
require("colors.gruvbox")

local scheme = "gruvbox"
local theme = "dark"

vim.cmd("colorscheme " .. scheme)

vim.o.background = theme

-- Highlight goodies
vim.cmd([[hi Normal ctermbg=none]])
vim.cmd([[hi NonText ctermbg=none]])
vim.cmd([[hi Normal guibg=000000]])
