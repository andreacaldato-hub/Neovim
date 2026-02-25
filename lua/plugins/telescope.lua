return {
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")
			local previewers = require("telescope.previewers")
			local builtin = require("telescope.builtin")
			local home = vim.fn.expand("~")

			require("telescope").setup({
				defaults = {
					hidden = true,
					layout_strategy = "flex",
					layout_config = { horizontal = { preview_width = 0.7 } },

					-- vertical red bar
					selection_caret = "▌ ", -- the FZF-style bar
					entry_prefix = " ", -- space before items
					buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
				},
			})

			telescope.load_extension("fzf")

			-- Put this inside your config = function() after telescope.load_extension("fzf")

			-- === Keymaps ===
			vim.keymap.set("n", "<leader>ff", function()
				builtin.find_files({
					cwd = vim.fn.getcwd(),
					hidden = true, -- show dotfiles
					file_ignore_patterns = { "^%.git/" }, -- ignore .git folder
				})
			end, { desc = "Find files (cwd)", silent = true })
			vim.keymap.set("n", "<leader>fn", function()
				builtin.find_files({ cwd = home .. "/dotfiles/.config/nvim" })
			end, { desc = "Find nvim config" })

			vim.keymap.set("n", "<leader>fc", function()
				require("telescope.builtin").find_files({
					cwd = home .. "/dotfiles",
					hidden = true,
					follow = false,
					file_ignore_patterns = { "%.git/", "%.swp$", "%.bak$" },
				})
			end, { desc = "Find dotfiles" })

			vim.keymap.set("n", "<leader>fF", function()
				builtin.find_files({ cwd = home, hidden = true, file_ignore_patterns = { "^%.git/" } })
			end, { desc = "Find home files" })

			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
		end,
	},
}
