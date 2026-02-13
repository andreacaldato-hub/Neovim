-- AutoFormatOnSave + LSP Attach
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("my.lsp", {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		-- Optional: trigger autocompletion on every keypress
		if client.supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = false })
		end

		-- Auto-format on save for servers that support formatting
		-- if
		--     not client.supports_method("textDocument/willSaveWaitUntil")
		--     and client.supports_method("textDocument/formatting")
		-- then
		--     vim.api.nvim_create_autocmd("BufWritePre", {
		--         group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
		--         buffer = args.buf,
		--         callback = function()
		--             vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
		--         end,
		--     })
		-- end
	end,
})

-- Main LSP config
return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Mason setup
		require("mason").setup({
			registries = { "github:crashdummyy/mason-registry", "github:mason-org/mason-registry" },
		})
		require("mason-lspconfig").setup()
		require("roslyn").setup()

		-- Diagnostics configuration
		vim.diagnostic.config({
			signs = {
				numhl = {
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
				},
				text = {
					[vim.diagnostic.severity.ERROR] = "X",
					[vim.diagnostic.severity.HINT] = "?",
					[vim.diagnostic.severity.INFO] = "I",
					[vim.diagnostic.severity.WARN] = "!",
				},
			},
			update_in_insert = false,
			virtual_text = false,
			virtual_lines = { current_line = true },
		})
	end,
	dependencies = {
		"seblyng/roslyn.nvim",
		"mason-org/mason-lspconfig.nvim",
		"mason-org/mason.nvim",
	},
}
