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
				"java",
			},
			highlight = {
				enable = true,
				-- false = disabilita l'highlighting "regex" di Vim quando è
				-- attivo quello di tree-sitter, così i colori non si mescolano.
				additional_vim_regex_highlighting = false,
			},
			indent = {
				enable = true,
			},
		})
	end,
}
