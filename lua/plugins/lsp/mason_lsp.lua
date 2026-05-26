return {
	-- mason: downloads LSP server binaries onto your machine
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	-- mason-lspconfig: tells mason which servers to install
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", -- Lua
					"pyright", -- Python
					"clangd", -- C/C++
				},
			})
		end,
	},
}
