-- lua/plugins/onedarkpro.lua
-- OneDark Pro colorscheme for lazy.nvim
-- Repo: https://github.com/olimorris/onedarkpro.nvim
-- Themes: onedark | onelight | onedark_vivid | onedark_dark

return {
	"olimorris/onedarkpro.nvim",
	lazy = false, -- load at startup (colorschemes should not be lazy loaded)
	priority = 1000, -- load before every other plugin

	config = function()
		local helpers = require("onedarkpro.helpers")

		require("onedarkpro").setup({

			---------------------------------------------------------------------
			-- COLORS
			-- Override palette colors per theme, or for all themes at the top level.
			-- Values can be hex strings or helper results.
			---------------------------------------------------------------------
			colors = {
				-- applies to every theme
				-- red = "#ff5555",

				-- theme-specific overrides
				onedark = {
					-- bg = "#1e222a",
					-- fg = "#c8ccd4",
					-- cursorline = "#2c313c",
					-- red = "#e06c75",
					-- orange = "#d19a66",
					-- yellow = "#e5c07b",
					-- green = "#98c379",
					-- cyan = "#56b6c2",
					-- blue = "#61afef",
					-- purple = "#c678dd",
					-- gray = "#5c6370",
					-- comment = "#7f848e",
				},
				onelight = {},
				onedark_vivid = {},
				onedark_dark = {},

				-- Derive colors from existing ones with helpers:
				--   helpers.darken("bg", 5, "onedark")
				--   helpers.lighten("bg", 5, "onedark")
				--   helpers.brighten("red", 10)
				-- Example:
				-- onedark = {
				--   cursorline = helpers.lighten("bg", 3, "onedark"),
				-- },
			},

			---------------------------------------------------------------------
			-- HIGHLIGHTS
			-- Override or add highlight groups. You can reference palette colors
			-- with "${name}" (e.g. "${red}", "${bg}", "${cursorline}").
			-- Existing groups are merged with what you provide.
			---------------------------------------------------------------------
			highlights = {
				-- Core
				-- Comment = { fg = "${gray}", italic = true },
				-- CursorLine = { bg = "${cursorline}" },
				-- CursorLineNr = { fg = "${yellow}", bold = true },
				-- LineNr = { fg = "${gray}" },
				-- Visual = { bg = "${selection}" },
				-- Normal = { bg = "NONE" },
				-- NormalFloat = { bg = "${bg}" },
				-- FloatBorder = { fg = "${blue}", bg = "${bg}" },
				-- WinSeparator = { fg = "${gray}" },

				-- Treesitter groups
				-- ["@keyword"] = { fg = "${purple}", italic = true },
				-- ["@function"] = { fg = "${blue}", bold = true },
				-- ["@string"] = { fg = "${green}" },
				-- ["@variable.parameter"] = { fg = "${orange}", italic = true },

				-- LSP semantic tokens
				-- ["@lsp.type.variable"] = { fg = "${fg}" },
				-- ["@lsp.typemod.function.declaration"] = { bold = true },

				-- Link one group to another
				-- MyGroup = { link = "Comment" },
			},

			---------------------------------------------------------------------
			-- STYLES
			-- Combine with commas: "bold,italic", "underline", "NONE"
			---------------------------------------------------------------------
			styles = {
				types = "NONE",
				methods = "NONE",
				numbers = "NONE",
				strings = "NONE",
				comments = "italic",
				keywords = "bold,italic",
				constants = "NONE",
				functions = "italic",
				operators = "NONE",
				variables = "NONE",
				parameters = "NONE",
				conditionals = "italic",
				virtual_text = "NONE",
			},

			---------------------------------------------------------------------
			-- FILETYPES
			-- Choose which filetype-specific highlight groups are loaded.
			-- `all = true` loads everything; set individual ones to false to skip.
			---------------------------------------------------------------------
			filetypes = {
				all = true,
				-- markdown = true,
				-- python = true,
				-- lua = true,
				-- javascript = true,
				-- typescript = true,
				html = false,
				-- php = true,
				-- ruby = true,
				-- rust = false,
				-- vue = false,
			},

			---------------------------------------------------------------------
			-- PLUGINS
			-- Choose which plugin highlight groups are loaded.
			---------------------------------------------------------------------
			plugins = {
				all = true,
				-- aerial = true,
				-- barbar = true,
				-- blink_cmp = true,
				-- copilot = true,
				-- dashboard = true,
				-- gitsigns = true,
				-- indentline = true,
				-- lazy = true,
				-- lsp_saga = true,
				-- lsp_semantic_tokens = true,
				-- mason = true,
				-- neo_tree = true,
				-- nvim_cmp = true,
				-- nvim_tree = true,
				-- telescope = true,
				-- toggleterm = true,
				-- treesitter = true,
				-- trouble = true,
				-- which_key = true,
			},

			---------------------------------------------------------------------
			-- OPTIONS
			---------------------------------------------------------------------
			options = {
				cursorline = true, -- use cursorline highlighting
				transparency = true, -- transparent background
				terminal_colors = true, -- set terminal colors (:terminal)
				lualine_transparency = false, -- transparent lualine center section
				highlight_inactive_windows = false, -- dim inactive windows
			},
		})

		-----------------------------------------------------------------------
		-- Apply the colorscheme
		-----------------------------------------------------------------------
		-- Pick one:
		vim.cmd("colorscheme onedark")
		-- vim.cmd("colorscheme onedark_vivid")
		-- vim.cmd("colorscheme onedark_dark")
		-- vim.cmd("colorscheme onelight")

		-- Or follow vim.o.background automatically:
		--   vim.o.background = "dark"   -- -> onedark
		--   vim.o.background = "light"  -- -> onelight
		-- (set one of the above BEFORE calling `colorscheme`)
	end,
}
