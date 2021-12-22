local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

local builtins = null_ls.builtins

null_ls.setup({
	debug = true,
	sources = {
		builtins.formatting.prettier,
    builtins.diagnostics.eslint,
		builtins.formatting.stylua,
	},
})
