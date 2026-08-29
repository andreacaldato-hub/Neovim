-- ─── Custom highlight overrides ───────────────────────────────────────────────
-- Applied on every ColorScheme change so custom styling persists across themes.
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- Floating windows
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		-- FloatBorder -> base per tutti i bordi dei picker Snacks (SnacksPickerBorder)
		-- e hover LSP. #3D3D3D e' il colore dei bordi Telescope (<leader>ff ecc.)
		-- cosi' i bordi sono coerenti con quelli di Telescope.
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#3D3D3D", bg = "NONE" })

		-- Blocchi di codice nei floating LSP (hover/signature): il contenuto dei
		-- code fence e' catturato come @markup.raw.block -> @markup.raw -> String
		-- (verde in kanagawa), quindi tutto il testo del hover Python diventa verde.
		-- Lo riportiamo sul fg normale dei documenti.
		local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
		vim.api.nvim_set_hl(0, "@markup.raw", { fg = normal_fg, bg = "NONE" })
		vim.api.nvim_set_hl(0, "@text.literal", { fg = normal_fg, bg = "NONE" })

		-- Line numbers
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#4a5568", bg = "NONE" })
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#3a4556", bg = "NONE" })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#3a4556", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#CBA85E", bg = "NONE", bold = true })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

		-- Visual selection
		vim.api.nvim_set_hl(0, "Visual", { bg = "#2a2a2a", fg = "NONE" })
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#CBA85E", fg = "#0a0e14" })
	end,
})

-- Suppress LSP progress spam (not highlight related, kept here)
vim.lsp.handlers["$/progress"] = function() end
