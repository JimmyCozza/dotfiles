return {
  -- {"github/copilot.vim"},
  {
    "sourcegraph/sg.vim",
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "nvim -l build/init.lua",
  },
  {
    "zbirenbaum/copilot.lua",
    event = { "VimEnter" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup({
          filetypes = {
            markdown = true,
          },
        })
      end, 100)
    end,
  },
  { "zbirenbaum/copilot-cmp" },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("copilot_cmp").setup()

      local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
      local icons = require("icons")

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        style = {
          winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s", icons.kind[vim_item.kind])

            if entry.source.name == "copilot" then
              vim_item.dup = 0
              vim_item.kind = icons.git.Octoface
            end
            -- Kind icons
            vim_item.menu = ({
              copilot = "[Copilot]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[NVIM_LUA]",
              ultisnips = "[Snippet]",
              buffer = "[Buffer]",
              path = "[Path]",
            })[entry.source.name]
            return vim_item
          end,
        },
        window = {
          completion = {
            border = icons.borders.RoundedRect,
            scrollbar = "║",
            autocomplete = {
              require("cmp.types").cmp.TriggerEvent.InsertEnter,
              require("cmp.types").cmp.TriggerEvent.TextChanged,
            },
          },
          documentation = {
            border = icons.borders.RoundedRect,
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            scrollbar = "║",
          },
        },
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            cmp_ultisnips_mappings.jump_backwards(fallback)
          end, { "i", "s" }),
        },
        experimental = {
          native_menu = false,
          ghost_text = true,
        },
        sources = {
          { name = "buffer" },
          {
            name = "copilot",
            max_item_count = 3,
            trigger_characters = {
              {
                ".",
                ":",
                "(",
                "'",
                '"',
                "[",
                ",",
                "#",
                "*",
                "@",
                "|",
                "=",
                "-",
                "{",
                "/",
                "\\",
                "+",
                "?",
                " ",
              },
            },
          },
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "orgmode" },
          { name = "path" },
          { name = "ultisnips" },
        },
        sorting = {
          comparators = {
            cmp.config.compare.recently_used,
            cmp.config.compare.offset,
            cmp.config.compare.score,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        preselect = cmp.PreselectMode.Item,
      })

      --set max height of items
      vim.cmd([[ set pumheight=10 ]])
    end,
  },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "quangnguyen30192/cmp-nvim-ultisnips" },
  { "SirVer/ultisnips" },
}
