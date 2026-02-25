-- Load plugins & snippets
require("config.lazy")
require("plugins.latex.snippets")

-- Function to set Blink highlights
local function set_blink_hl()
	-- Menu

	vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE", fg = "#c0c0c0" })

	vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#1f2329", fg = "NONE", bold = true })

	vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#1f2329" })

	-- Labels

	vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "NONE", bg = "NONE" })

	vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#c8c093", bg = "NONE" })

	-- Documentation

	vim.api.nvim_set_hl(0, "BlinkCmpDoc", { fg = "#c0c0c0", bg = "NONE" })

	vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#1f2329" })

	-- Cursor line

	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#000000" })
	-- Nella tua funzione set_blink_hl()
	vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", {
		fg = "NONE", -- Usa lo stesso colore che hai impostato per "BlinkCmpLabel"
		bg = "NONE",
		bold = false,
		nocombine = true, -- Importante: impedisce ad altri hl di combinarsi sopra
	})

	-- Forza anche il match per la descrizione se presente
	vim.api.nvim_set_hl(0, "BlinkCmpLabelMatchDescription", {
		fg = "NONE",
		bg = "NONE",
		bold = false,
	})
end
-- Apply on startup and on colorscheme changes
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, { callback = set_blink_hl })
