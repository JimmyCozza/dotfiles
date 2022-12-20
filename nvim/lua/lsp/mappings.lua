local map = require("helpers").map

local function set_lsp_mappings(client)
  map("n", "gD", function()
    vim.lsp.buf.declaration()
  end)

  map("n", "gd", function()
    vim.lsp.buf.definition()
  end)

  map("n", "K", function()
    vim.lsp.buf.hover()
  end)

  map("n", "gi", function()
    vim.lsp.buf.implementation()
  end)

  map("n", "gr", function()
    vim.lsp.buf.references()
  end)

  map("n", "[d", function()
    vim.diagnostic.goto_prev()
  end)

  map("n", "d]", function()
    vim.diagnostic.goto_next()
  end)
end

return set_lsp_mappings
