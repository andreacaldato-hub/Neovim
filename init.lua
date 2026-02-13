require("config.lazy")
-- require("lsp")
require("plugins.latex.snippets")
local capabilities = require('blink.cmp').get_lsp_capabilities()
-- Put this in :lua prompt or init.lua temporarily
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "NONE", fg = "#c8c093" })
vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#202028", fg = "#E7C664", bold = true })
vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#c8c093" })

vim.api.nvim_set_hl(0, "BlinkCmpLabel", {
    fg = "#7B7A7B", -- your non-selected color
    bg = "NONE",
})

-- after loading your colorscheme
vim.cmd [[
  " Highlight JS/TS member properties
  hi link @property Identifier
]]
