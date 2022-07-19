local map = require("helpers").map

local function set_lsp_mappings()
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

  --map("n", "<leader>D", function()
  --vim.lsp.buf.type_definition()
  --end)

  --map("n", "<leader>ra", function()
  --vim.lsp.buf.rename()
  --end)

  --map("n", "<leader>ca", function()
  --vim.lsp.buf.code_action()
  --end)

  --map("n", "<leader>f", function()
  --vim.diagnostic.open_float()
  --end)

  --map("n", "<leader>q", function()
  --vim.diagnostic.setloclist()
  --end)

  --map("n", "<leader>fm", function()
  --vim.lsp.buf.formatting()
  --end)

  --map("n", "<leader>wa", function()
  --vim.lsp.buf.add_workspace_folder()
  --end)

  --map("n", "<leader>wr", function()
  --vim.lsp.buf.remove_workspace_folder()
  --end)

  --map("n", "<leader>wl", function()
  --print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --end)
end

return set_lsp_mappings
