local has_lsp, lspconfig = pcall(require, "lspconfig")
if not has_lsp then
  return
end

local lspconfig_util = require "lspconfig.util"

local nvim_status = require "lsp-status"

local handlers = require "lsp.handlers"

local ts_util = require "nvim-lsp-ts-utils"

local status = require "lsp.status"
status.activate()

local custom_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local filetype_attach = setmetatable({
  go = function(client)
    vim.cmd [[
      augroup lsp_buf_format
        au! BufWritePre <buffer>
        autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
  end
}, {
  __index = function()
    return function() end
  end,
})

local buf_nnoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  vim.keymap.set("n", opts[1], opts[2], opts[3])
end

local buf_inoremap = function(opts)
  if opts[3] == nil then
    opts[3] = {}
  end
  opts[3].buffer = 0

  vim.keymap.set("i", opts[1], opts[2], opts[3])
end

local custom_attach = function(client)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")

  nvim_status.on_attach(client)

  buf_inoremap { "<c-s>", vim.lsp.buf.signature_help }
  buf_nnoremap { "gd", vim.lsp.buf.definition }
  buf_nnoremap { "gD", vim.lsp.buf.declaration }
  buf_nnoremap { "gT", vim.lsp.buf.type_definition }

  if filetype ~= "lua" then
    buf_nnoremap { "K", vim.lsp.buf.hover, { desc = "lsp:hover" } }
  end

  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end

  -- Attach any filetype specific options to the client
  filetype_attach[filetype](client)
end

local updated_capabilities = vim.lsp.protocol.make_client_capabilities()
updated_capabilities = vim.tbl_deep_extend("keep", updated_capabilities, nvim_status.capabilities)
updated_capabilities = require("cmp_nvim_lsp").update_capabilities(updated_capabilities)

-- TODO: check if this is the problem.
updated_capabilities.textDocument.completion.completionItem.insertReplaceSupport = false

local servers = {
  graphql = false,
  html = true,
  vimls = true,
  yamlls = true,
  eslint = false,
  cmake = (1 == vim.fn.executable "cmake-language-server"),
  dartls = pcall(require, "flutter-tools"),
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "use", "awesome", "screen" },
          disable = { "lowercase-global" }
        },
        workspace = {
          library = {
            [vim.fn.expand "$VIMRUNTIME/lua"] = true,
            [vim.fn.stdpath "config" .. "/lua"] = true,
          },
        },
      },
    },
    on_attach = function(client)
      vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
      custom_attach(client)
    end,
  },
  gopls = {
    root_dir = function(fname)
      local Path = require "plenary.path"

      local absolute_cwd = Path:new(vim.loop.cwd()):absolute()
      local absolute_fname = Path:new(fname):absolute()

      if string.find(absolute_cwd, "/cmd/", 1, true) and string.find(absolute_fname, absolute_cwd, 1, true) then
        return absolute_cwd
      end

      return lspconfig_util.root_pattern("go.mod", ".git")(fname)
    end,

    settings = {
      gopls = {
        codelenses = { test = true },
      },
    },

    flags = {
      debounce_text_changes = 200,
    },
  },
  tsserver = {
    init_options = ts_util.init_options,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "json",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },

    on_attach = function(client)
      custom_attach(client)

      ts_util.setup { auto_inlay_hints = false }
      ts_util.setup_client(client)
    end,
  },
}

local setup_server = function(server, config)
  if not config then
    return
  end

  if type(config) ~= "table" then
    config = {}
  end

  config = vim.tbl_deep_extend("force", {
    on_init = custom_init,
    on_attach = custom_attach,
    capabilities = updated_capabilities,
    flags = {
      debounce_text_changes = nil,
    },
  }, config)

  lspconfig[server].setup(config)
end

for server, config in pairs(servers) do
  setup_server(server, config)
end

--require "configs.null-ls"

return {
  on_init = custom_init,
  on_attach = custom_attach,
  capabilities = updated_capabilities,
}
