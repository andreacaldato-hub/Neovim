return {
	-- mason-tool-installer: installs formatters, linters and other non-LSP tools
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					"stylua", -- Lua
					"clang-format", -- C/C++
					"black", -- Python
					"shfmt", -- shell
					"google-java-format", -- Java
				},
			})
		end,
	},
}
