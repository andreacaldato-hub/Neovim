-- load plugins & snippets
require("config.lazy")
require("plugins.latex.snippets")
-- Custom Blink appearance
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE", fg = "#c8c093" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#202028", fg = "#E7C664", bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#c8c093" })
vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "#7B7A7B", bg = "NONE" })
-- Syntax-specific highlight tweaks
vim.cmd([[
  hi link @property Identifier
]])
