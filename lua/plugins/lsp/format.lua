local M = {
	format_on_save_enabled = true,
}

vim.keymap.set("n", "<leader>ft", function()
	M.format_on_save_enabled = not M.format_on_save_enabled
	print("Format on save: " .. (M.format_on_save_enabled and "ON" or "OFF"))
end, { desc = "Toggle format on save" })

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		format_on_save = function(bufnr)
			if not M.format_on_save_enabled then return end
			return {
				timeout_ms = 1000,
				lsp_fallback = true,
			}
		end,
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
			zsh = { "shfmt" },
		},
	},
}
