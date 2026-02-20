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
					previewer = true, -- enable built-in previewer (bat for files)
					grouped = true, -- enable built-in previewer (bat for files)
					git_status = false,
				},
			},
		})

		telescope.load_extension("file_browser")

		vim.keymap.set("n", "<leader>a", function()
			local cwd = vim.fn.expand("%:p:h") -- get current file's directory
			telescope.extensions.file_browser.file_browser({
				cwd = cwd,
				layout_config = { horizontal = { preview_width = 0.5 } },
				initial_mode = "normal",
			})
		end)
	end,
}
