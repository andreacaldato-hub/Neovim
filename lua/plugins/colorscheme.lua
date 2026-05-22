-- return {
-- "tiagovla/tokyodark.nvim",
-- priority = 1000,
-- opts = {
--   transparent_background = true,
--   gamma = 1.0,
--   styles = {
--     comments = { italic = true },
--     keywords = { italic = true },
--     identifiers = { italic = true },
--     functions = { italic = true },
--     variables = { italic = true },
--   },
--   custom_highlights = function(highlights, palette)
--     highlights.Comment = { fg = palette.grey, italic = true, bold = true }
--     return highlights
--   end,
-- },
-- config = function(_, opts)
--   require("tokyodark").setup(opts)
--   vim.cmd([[colorscheme tokyodark]])
-- end,
return {
  "Shatur/neovim-ayu",
  lazy = false,
  priority = 1000,
  config = function()
    local colors = require("ayu.colors")
    colors.generate(false) -- false = dark, true = mirage
    require("ayu").setup({
      mirage = false,
      terminal = true,
      overrides = {
        -- transparency
        Normal                                          = { bg = "None" },
        NormalNC                                        = { bg = "None" },
        NormalFloat                                     = { bg = "None" },
        FloatBorder                                     = { bg = "None" },
        FloatTitle                                      = { bg = "None" },
        EndOfBuffer                                     = { bg = "None" },
        MsgArea                                         = { bg = "None" },
        Pmenu                                           = { bg = "None" },
        PmenuSel                                        = { bg = "None" },
        PmenuSbar                                       = { bg = "None" },
        PmenuThumb                                      = { bg = "None" },
        CursorLine                                      = { bg = "None" },
        CursorColumn                                    = { bg = "None" },
        ColorColumn                                     = { bg = "None" },
        SignColumn                                      = { bg = "None" },
        Folded                                          = { bg = "None" },
        FoldColumn                                      = { bg = "None" },
        VertSplit                                       = { bg = "None" },
        WinSeparator                                    = { bg = "None" },
        StatusLine                                      = { bg = "None" },
        StatusLineNC                                    = { bg = "None" },
        TabLine                                         = { bg = "None" },
        TabLineFill                                     = { bg = "None" },
        TabLineSel                                      = { bg = "None" },
        DiagnosticVirtualTextError                      = { bg = "None" },
        DiagnosticVirtualTextWarn                       = { bg = "None" },
        DiagnosticVirtualTextInfo                       = { bg = "None" },
        DiagnosticVirtualTextHint                       = { bg = "None" },
        TelescopeNormal                                 = { bg = "None" },
        TelescopeBorder                                 = { bg = "None" },
        TelescopePromptNormal                           = { bg = "None" },
        TelescopePromptBorder                           = { bg = "None" },
        TelescopeResultsNormal                          = { bg = "None" },
        TelescopeResultsBorder                          = { bg = "None" },
        TelescopePreviewNormal                          = { bg = "None" },
        TelescopePreviewBorder                          = { bg = "None" },
        NvimTreeNormal                                  = { bg = "None" },
        NvimTreeNormalNC                                = { bg = "None" },
        NvimTreeEndOfBuffer                             = { bg = "None" },
        NvimTreeWinSeparator                            = { bg = "None" },
        NeoTreeNormal                                   = { bg = "None" },
        NeoTreeNormalNC                                 = { bg = "None" },
        WhichKeyFloat                                   = { bg = "None" },
        WhichKeyBorder                                  = { bg = "None" },
        Comment                                         = { fg = colors.comment, italic = true },
        Constant                                        = { fg = "#90E1C6" },
        CInclude                                        = { fg = "#FE8E40" },
        CDefine                                         = { fg = "#FE8E40" },
        pythonFunction                                  = { fg = "#F9AF4F" },
        ["@type.builtin"]                               = { fg = "#37B1DB", italic = true },
        ["@variable"]                                   = { fg = "#BFBDB6", italic = true },
        ["@lsp.typemod.parameter.functionScope.c"]      = { fg = "#C89EF3", italic = true },
        ["@lsp.typemod.macro.globalScope.c"]            = { fg = "#F9AF4F", italic = true },
        ["@lsp.typemod.function.defaultLibrary.c"]      = { fg = "#D95757" },
        -- ["@lsp.typemod.function.globalScope.c"]         = { fg = "#F9AF4F", italic = true },
        ["@lsp.typemod.parameter.declaration.c"]        = { fg = "#C89EF3", italic = true },
        -- ["@lsp.typemod.variable.functionScope.c"]       = { fg = "#C89EF3", italic = true },
        ["@punctuation.special.c"]                      = { fg = "#FFB454" },
        ["pythonInclude"]                               = { fg = "#FE8E40" },
        ["@lsp.type.namespace.python"]                  = { fg = "#BFBDB6" },
        ["@lsp.type.parameter.python"]                  = { fg = "#C89EF3", italic = true },
        ["@lsp.mod.parameter.python"]                   = { fg = "#C89EF3", italic = true },
        ["@lsp.typemod.function.declaration.python"]    = { fg = "#F9AF4F" },
        ["@lsp.typemod.parameter.parameter.python"]     = { fg = "#C89EF3", italic = true },
        ["@lsp.typemod.parameter.declaration.python"]   = { fg = "#C89EF3", italic = true },
        ["@lsp.mod.declaration.python"]                 = { fg = "#C89EF3", italic = true },
        ["@lsp.typemod.function.defaultLibrary.python"] = { fg = "#D95757" },

      },
    })
    vim.cmd("colorscheme ayu")
  end,
}
-- return {
--   "catppuccin/nvim",
--   name = "catppuccin",
--   priority = 1000,
--   config = function()
--     require("catppuccin").setup({
--       flavour = "auto", -- latte, frappe, macchiato, mocha
--       background = {    -- :h background
--         light = "latte",
--         dark = "mocha",
--       },
--       transparent_background = true, -- disables setting the background color.
--       float = {
--         transparent = true,          -- enable transparent floating windows
--         solid = false,               -- use solid styling for floating windows, see |winborder|
--       },
--       term_colors = true,            -- sets terminal colors (e.g. `g:terminal_color_0`)
--       dim_inactive = {
--         enabled = false,             -- dims the background color of inactive window
--         shade = "dark",
--         percentage = 0.15,           -- percentage of the shade to apply to the inactive window
--       },
--       no_italic = false,             -- Force no italic
--       no_bold = false,               -- Force no bold
--       no_underline = false,          -- Force no underline
--       styles = {                     -- Handles the styles of general hi groups (see `:h highlight-args`):
--         comments = { "italic" },     -- Change the style of comments
--         conditionals = { "italic" },
--         loops = {},
--         functions = {},
--         keywords = {},
--         strings = {},
--         variables = {},
--         numbers = {},
--         booleans = {},
--         properties = {},
--         types = {},
--         operators = {},
--         -- miscs = {}, -- Uncomment to turn off hard-coded styles
--       },
--       lsp_styles = { -- Handles the style of specific lsp hl groups (see `:h lsp-highlight`).
--         virtual_text = {
--           errors = { "italic" },
--           hints = { "italic" },
--           warnings = { "italic" },
--           information = { "italic" },
--           ok = { "italic" },
--         },
--         underlines = {
--           errors = { "underline" },
--           hints = { "underline" },
--           warnings = { "underline" },
--           information = { "underline" },
--           ok = { "underline" },
--         },
--         inlay_hints = {
--           background = false,
--         },
--       },
--       color_overrides = {},
--       custom_highlights = {},
--       default_integrations = true,
--       auto_integrations = false,
--       integrations = {
--         cmp = true,
--         gitsigns = true,
--         nvimtree = true,
--         notify = false,
--         mini = {
--           enabled = true,
--           indentscope_color = "",
--         },
--         -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--       },
--     })
--
--     -- setup must be called before loading
--     vim.cmd.colorscheme "catppuccin-nvim"
--   end
-- }
-- config = function()
-- 	-- Lua
-- 	require("onedark").setup({
-- 		-- Main options --
-- 		style = "darker", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
-- 		transparent = true, -- Show/hide background
-- 		term_colors = true, -- Change terminal color as per the selected theme style
-- 		ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
-- 		cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
-- 		-- toggle theme style ---
-- 		toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
-- 		toggle_style_list = { "dark", "darker", "cool", "deep", "warm", "warmer", "light" }, -- List of styles to toggle between
--
-- 		-- Change code style ---
-- 		-- Options are italic, bold, underline, none
-- 		-- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
-- 		code_style = {
-- 			comments = "italic",
-- 			keywords = "italic",
-- 			functions = "italic",
-- 			strings = "italic",
-- 			variables = "italic",
-- 		},
--
-- 		-- Lualine options --
-- 		lualine = {
-- 			transparent = true, -- lualine center bar transparency
-- 		},
--
-- 		-- Custom Highlights --
-- 		colors = {
-- 			-- purple = "#E2EFDE",
-- 			-- cyan = "#c0c0c0",
-- 			-- orange = "#e8c88c",
-- 			-- green = "#a3be8c",
-- 		},
-- 		-- All'interno di require("onedark").setup({ ...
-- 		highlights = {
-- 			-- Funzioni standard (es. printf) e globali
-- 			-- ["@lsp.type.function"] = { fg = "$purple", fmt = "italic" },
-- 			-- ["@lsp.typemod.function.defaultLibrary"] = { fg = "$purple", fmt = "italic" },
-- 			-- ["@lsp.typemod.function.globalScope"] = { fg = "$purple", fmt = "italic" },
-- 			--
-- 			-- -- Modificatori (per essere sicuri che il colore "tenga")
-- 			-- ["@lsp.mod.defaultLibrary"] = { fg = "$purple" },
-- 			-- ["@lsp.mod.globalScope"] = { fg = "$purple" },
-- 			--
-- 			-- -- Manteniamo l'include rosso/purple come prima
-- 			-- ["cInclude"] = { fg = "#94C5CC" },
-- 			-- ["Repeat"] = { fg = "#94C5CC" },
-- 			["Function"] = { fg = "#E2EFDE" },
-- 			-- ["cPreProc"] = { fg = "#94C5CC" },
-- 		},
-- 		-- Plugins Config --
-- 		diagnostics = {
-- 			darker = true, -- darker colors for diagnostic
-- 			undercurl = true, -- use undercurl instead of underline for diagnostics
-- 			background = true, -- use background color for virtual text
-- 		},
-- 	})
--
-- 	require("onedark").load()
-- end,
