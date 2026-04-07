return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	config = function()
		local telescope = require("telescope")
		telescope.setup({
			defaults = {
				layout_config = { horizontal = { preview_width = 0.5 } },
			},
			extensions = {
				file_browser = {
					hidden = true,
					previewer = true,
					grouped = true,
					respect_gitignore = false,
					hide_parent_folder = false,
					git_status = false,
					git_icons = {
						added = "A",
						changed = "M",
						copied = "C",
						deleted = "D",
						renamed = "R",
						unmerged = "U",
						untracked = "?",
					},
				},
			},
		})

		telescope.load_extension("file_browser")

		vim.keymap.set("n", "<leader>a", function()
			local path = vim.fn.expand("%:p")
			if path == "" then
				path = vim.fn.getcwd()
			end
			local cwd = vim.fn.fnamemodify(path, ":h")
			telescope.extensions.file_browser.file_browser({
				cwd = cwd,
				layout_config = { horizontal = { preview_width = 0.5 } },
				initial_mode = "normal",
			})
		end)
	end,
}
