require("config.lazy")
require("plugins.latex.snippets")
local function set_blink_hl()
	vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE", fg = "#c0c0c0" })
	vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#1f2329", fg = "NONE", bold = true })
	vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#1f2329" })
	vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "NONE", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#c8c093", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BlinkCmpDoc", { fg = "#c0c0c0", bg = "NONE" })
	vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#1f2329" })
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#0A0A0A" })
	vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", {

		fg = "NONE", -- Usa lo stesso colore che hai impostato per "BlinkCmpLabel"
		bg = "NONE",
		bold = false,
		nocombine = true, -- Importante: impedisce ad altri hl di combinarsi sopra
	})

	vim.api.nvim_set_hl(0, "String", { fg = "#89b482", italic = true }) -- Gruvbox Aqua
	vim.api.nvim_set_hl(0, "BlinkCmpLabelMatchDescription", {
		fg = "NONE",
		bg = "NONE",
		bold = false,
	})
end
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, { callback = set_blink_hl })
-- This removes the background color from all floating windows
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })
