return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" }, -- format on save
	opts = {
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = true,
		},

		formatters_by_ft = {
			lua = { "stylua" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			javascriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			python = { "black" },
			c = { "clang_format" },
			cpp = { "clang_format" },
		},
	},
}
