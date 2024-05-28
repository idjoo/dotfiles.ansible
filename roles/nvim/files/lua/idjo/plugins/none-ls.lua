return {
	"jay-babu/mason-null-ls.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>bf",
			function()
				vim.lsp.buf.format({ async = true })
			end,
			"formatting",
		},
	},
	dependencies = {
		"williamboman/mason.nvim",
		{
			"nvimtools/none-ls.nvim",
			config = function(plugin, opts)
				local null_ls = require("null-ls")

				null_ls.setup({
					sources = {
						-- lua
						null_ls.builtins.formatting.stylua,

						-- groovy
						null_ls.builtins.formatting.npm_groovy_lint.with({
							filetypes = { "groovy", "jenkinsfile" },
						}),
						-- null_ls.builtins.diagnostics.npm_groovy_lint.with({
						-- 	filetypes = { "groovy", "jenkinsfile" },
						-- }),
					},
				})
			end,
		},
	},

	opts = {
		ensure_installed = nil,

		methods = {
			diagnostics = true,
			formatting = true,
			code_actions = true,
			completion = true,
			hover = true,
		},

		automatic_installation = {
			exclude = {
				"stylua",
			},
		},
	},
}
