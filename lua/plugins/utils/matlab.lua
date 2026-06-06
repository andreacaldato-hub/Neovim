return {
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
				environment = {
					QT_QPA_PLATFORM = "xcb",
				},
				debug = true,
			})
		end,
	},
}
