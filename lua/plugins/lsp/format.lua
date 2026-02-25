-- Toggle format on save
local format_on_save_enabled = true

vim.keymap.set("n", "<leader>ft", function()
  ciao
	format_on_save_enabled = not format_on_save_enabled

	require("conform").setup({
		format_on_save = format_on_save_enabled and {
			timeout_ms = 1000,
			lsp_fallback = true,
		} or false,
	})

	print("Format on save: " .. (format_on_save_enabled and "ON" or "OFF"))
end, { desc = "Toggle format on save" })
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
