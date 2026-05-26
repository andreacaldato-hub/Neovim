return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {
				"lua",
				"python",
				"json",
				"jsonc",
				"javascript",
				"html",
				"c",
				"cpp",
				"markdown",
				"latex",
				"bibtex",
				"luau",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
