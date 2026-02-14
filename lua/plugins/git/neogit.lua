return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},

	keys = {
		{
			"<leader>gg",
			function()
				require("neogit").open({ kind = "tab" })
			end,
			desc = "Open Neogit UI",
		},
	},

	config = function()
		require("neogit").setup({})
	end,
}
