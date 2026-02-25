-- load plugins & snippets
require("config.lazy")
require("plugins.latex.snippets")
-- Custom Blink appearance vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE", fg = "#c8c093" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "NONE", fg = "#EA9A97", bold = false })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#908caa" })
vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "#c8c093", bg = "#202028" })
vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#c8c093", bg = "#202028" })
vim.api.nvim_set_hl(0, "BlinkCmpDoc", { fg = "#E7C664", bg = "NONE" })
vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#908caa" })
vim.cmd([[
  hi link @property Identifier
]])

vim.api.nvim_set_hl(0, "CursorLine", { bg = "#070707" })
