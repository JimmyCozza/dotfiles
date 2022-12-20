local ok, notify = pcall(require, "notify")
if not ok then
  return
end
local icons = require("icons")

notify.setup({
  stages = "fade_in_slide_out",
  on_open = nil,
  on_close = nil,
  render = "default",
  timeout = 5000,
  background_colour = "#2c2e34",
  minimum_width = 50,
  icons = {
    ERROR = icons.diagnostics.BoldError,
    WARN = icons.diagnostics.BoldWarning,
    INFO = icons.diagnostics.BoldInformation,
    DEBUG = icons.diagnostics.Debug,
    TRACE = icons.diagnostics.Trace,
  },
})

vim.notify = notify
