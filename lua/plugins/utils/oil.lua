return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional but pretty
	config = function()
		require("oil").setup({
			default_file_explorer = true,

			columns = {
				"icon",
				"permissions",
				"size",
				"mtime",
			},

			buf_options = {
				buflisted = false,
				bufhidden = "hide",
			},

			win_options = {
				wrap = false,
				cursorline = true,
				signcolumn = "no",
				foldcolumn = "0",
				spell = false,
				list = false,
			},

			delete_to_trash = true,

			view_options = {
				show_hidden = false,
				natural_order = true,
				case_insensitive = true,
				sort = {
					{ "type", "asc" }, -- folders first
					{ "name", "asc" },
				},
			},

			keymaps = {},
		})

		-- 🔥 KEYBIND TO OPEN OIL
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

		-- Optional: open Oil floating window
		vim.keymap.set("n", "<leader>o", function()
			require("oil").open_float()
		end, { desc = "Open Oil (float)" })
	end,
}
