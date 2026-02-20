return {
	-- {
	-- 	"sainnhe/sonokai",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.g.sonokai_enable_italic = false
	-- 		vim.g.sonokai_transparent_background = 1
	--
	-- 		vim.cmd("colorscheme sonokai")
	-- local hi = vim.api.nvim_set_hl
	--
	-- 		-- Core transparency
	--
	-- 		--Floating windows
	-- 		hi(0, "NormalFloat", { bg = "none" })
	-- 		hi(0, "FloatBorder", { bg = "none" })
	--
	-- 		-- -- Lazy.nvim
	-- 		-- hi(0, "LazyNormal", { bg = "none" })
	--
	-- 		-- -- Mason
	-- 		-- hi(0, "MasonNormal", { bg = "none" })
	--
	-- 		-- -- Prevent overwrite on reload
	-- 		-- vim.api.nvim_create_autocmd("ColorScheme", {
	-- 		--     pattern = "*",
	-- 		--     callback = function()
	-- 		--         hi(0, "NormalFloat", { bg = "none" })
	-- 		--         hi(0, "FloatBorder", { bg = "none" })
	-- 		--         hi(0, "NeoTreeNormal", { bg = "none" })
	-- 		--         hi(0, "NeoTreeFloat", { bg = "none" })
	-- 		--         hi(0, "LazyNormal", { bg = "none" })
	-- 		--         hi(0, "MasonNormal", { bg = "none" })
	-- 		--     end,
	-- 		-- })
	-- 	end,
	-- },
	"rose-pine/neovim",
	name = "rose-pine",
	config = function()
		vim.cmd("colorscheme rose-pine")

		require("rose-pine").setup({
			variant = "moon", -- auto, main, moon, or dawn
			dark_variant = "main", -- main, moon, or dawn
			dim_inactive_windows = false,
			extend_background_behind_borders = false,

			enable = {
				terminal = true,
				legacy_highlights = false, -- Improve compatibility for previous versions of Neovim
				migrations = true, -- Handle deprecated options automatically
			},

			styles = {
				bold = true,
				italic = false,
				transparency = true,
			},

			groups = {
				border = "muted",
				link = "iris",
				panel = "surface",

				error = "love",
				hint = "iris",
				info = "foam",
				note = "pine",
				todo = "rose",
				warn = "gold",

				git_add = "foam",
				git_change = "rose",
				git_delete = "love",
				git_dirty = "rose",
				git_ignore = "muted",
				git_merge = "iris",
				git_rename = "pine",
				git_stage = "iris",
				git_text = "rose",
				git_untracked = "subtle",

				h1 = "iris",
				h2 = "foam",
				h3 = "rose",
				h4 = "gold",
				h5 = "pine",
				h6 = "foam",
			},

			palette = {
				-- Override the builtin palette per variant
				-- moon = {
				--     base = '#18191a',
				--     overlay = '#363738',
				-- },
			},

			-- NOTE: Highlight groups are extended (merged) by default. Disable this
			-- per group via `inherit = false`
			highlight_groups = {
				-- Comment = { fg = "foam" },
				-- StatusLine = { fg = "love", bg = "love", blend = 15 },
				-- VertSplit = { fg = "muted", bg = "muted" },
				-- Visual = { fg = "base", bg = "text", inherit = false },
			},

			before_highlight = function(group, highlight, palette)
				-- Disable all undercurls
				-- if highlight.undercurl then
				--     highlight.undercurl = false
				-- end
				--
				-- Change palette colour
				-- if highlight.fg == palette.pine then
				--     highlight.fg = palette.foam
				-- end
			end,
		})

		vim.cmd("colorscheme rose-pine")
		-- vim.cmd("colorscheme rose-pine-main")
		-- vim.cmd("colorscheme rose-pine-moon")
		-- vim.cmd("colorscheme rose-pine-dawn")
		--
		local hi = vim.api.nvim_set_hl
		-- Core transparency
		--Floating windows
		hi(0, "NormalFloat", { bg = "none" })
		hi(0, "FloatBorder", { bg = "none" })
		-- -- Lazy.nvim
		hi(0, "LazyNormal", { bg = "none" })
		-- Mason
		hi(0, "MasonNormal", { bg = "none" })
		-- Prevent overwrite on reload
		vim.api.nvim_create_autocmd("ColorScheme", {
			pattern = "*",
			callback = function()
				hi(0, "NormalFloat", { bg = "none" })
				hi(0, "FloatBorder", { bg = "none" })
				hi(0, "BlinkCmpDoc", { bg = "none" })
				hi(0, "BlinkCmpDocBorder", { bg = "none" })
				hi(0, "CmpDocumentation", { bg = "none" })
				hi(0, "CmpDocumentationBorder", { bg = "none" })
				hi(0, "Pmenu", { bg = "none" })
				hi(0, "PmenuSel", { bg = "none" })
				hi(0, "LazyNormal", { bg = "none" })
				hi(0, "MasonNormal", { bg = "none" })
				hi(0, "NeoTreeNormal", { bg = "none" })
				hi(0, "NeoTreeFloat", { bg = "none" })
			end,
		})
	end,
}
