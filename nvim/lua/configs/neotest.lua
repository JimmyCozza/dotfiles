require("neotest").setup({
  adapters = {
    require("neotest-plenary"),
    require("neotest-go"),
    require("neotest-jest")({
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  },
})