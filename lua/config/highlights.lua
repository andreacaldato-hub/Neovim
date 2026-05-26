vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- floating windows
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

		-- line numbers
		vim.api.nvim_set_hl(0, "LineNr", { fg = "#4a5568", bg = "NONE" })
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#3a4556", bg = "NONE" })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#3a4556", bg = "NONE" })
		vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffb454", bg = "NONE", bold = true })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
		vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })

		-- visual selection
		vim.api.nvim_set_hl(0, "Visual", { bg = "#2d4060", fg = "NONE" })
		vim.api.nvim_set_hl(0, "IncSearch", { bg = "#ffb454", fg = "#0a0e14" })
	end,
})

-- suppress LSP progress spam (not highlight related, stays outside)
vim.lsp.handlers["$/progress"] = function() end
