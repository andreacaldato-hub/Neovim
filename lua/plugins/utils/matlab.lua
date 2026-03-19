return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {
			open_mapping = [[<c-\>]],
			direction = "float",
			float_opts = {
				border = "curved",
				width = 60,
				height = 20,
				winblend = 3,
				row = 1,
				col = vim.o.columns - 65,
			},
		},
		keys = {
			{ "<c-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
			{ "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
			{ "<leader>tc", "<cmd>ToggleTerm<cr>", desc = "Close terminal" },
			-- from inside the terminal, use <C-\><C-n> to go to normal mode
			-- then these work too
		},
	},
	{
		"idossha/matlab.nvim",
		ft = "matlab",
		config = function()
			require("matlab").setup({
				executable = "matlab",
				panel_size = 35,
				panel_size_type = "percentage",
				tmux_pane_direction = "right",
				tmux_pane_focus = false,
				auto_start = false,
				default_mappings = true,
				minimal_notifications = true,
				environment = {},
				debug = true,
			})
		end,
	},
}
