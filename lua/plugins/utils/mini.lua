-- lua/plugins/mini-surround.lua
return {
	{
		"echasnovski/mini.surround",
		version = false,
		event = "VeryLazy",
		-- Disable LazyVim's default min.surround
		opts = {
			mappings = {
				add = "sa", -- sa{motion}{char} e.g. saiw)
				delete = "sd", -- sd{char}          e.g. sd)
				replace = "sr", -- sr{old}{new}       e.g. sr)"
				highlight = "sh", -- sh{char}  highlight
				update_n_lines = "sn", -- sn        update search range
			},
			n_lines = 20, -- how many lines to search for surrounding
		},
	},

	-- Disable LazyVim's built-in mini.surround to avoid conflicts
	{ "echasnovski/mini.surround", enabled = true },
}
