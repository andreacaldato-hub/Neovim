return {
	"stevearc/conform.nvim",
	event = "BufWritePre", -- load just before saving a file

	config = function()
		require("conform").setup({

			formatters_by_ft = {
				lua = { "stylua" }, -- lua formatter
				c = { "clang_format" }, -- C formatter
				cpp = { "clang_format" }, -- C++ formatter
				python = { "black" }, -- python formatter
				sh = { "shfmt" }, -- covers .zshrc, .bashrc, shell scripts
				zsh = { "shfmt" }, -- explicit zsh
			},

			format_on_save = {
				timeout_ms = 500, -- give formatter 500ms before giving up
				lsp_fallback = false, -- don't fall back to LSP formatting
			},
		})
	end,
}
