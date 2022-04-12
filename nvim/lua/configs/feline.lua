local ok, feline = pcall(require, "feline")
if not ok then
  return
end

feline.setup {
  components = require "catppuccin.core.integrations.feline",
}
