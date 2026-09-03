return {
	"saghen/blink.cmp",
	version = "*",
	event = "InsertEnter",

	opts = {
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },
			["<Up>"] = { "select_prev", "fallback" },
			["<Down>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },
			["<C-f>"] = { "accept", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
		},
		completion = {
			list = {
				selection = {
					preselect = true, -- don't auto-select the first item
					auto_insert = false, -- don't auto-insert until you explicitly select
				},
			},
			menu = {
				border = "rounded",
				winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				window = {
					border = "rounded",
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder",
				},
			},
			ghost_text = {
				enabled = true, -- inline ghost text like vscode
			},
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},

		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
	},

	config = function(_, opts)
		require("blink.cmp").setup(opts)

		vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = "#09090a", fg = "#b0b0b0" }) -- menu background and text
		vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection", { bg = "#222222", fg = "NONE", bold = true }) -- selected item
		vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder", { fg = "#2a2a2a" }) -- menu border
		vim.api.nvim_set_hl(0, "BlinkCmpLabel", { fg = "NONE", bg = "NONE" }) -- completion item text
		vim.api.nvim_set_hl(0, "BlinkCmpLabelDescription", { fg = "#50585d", bg = "NONE" }) -- item description text
		vim.api.nvim_set_hl(0, "BlinkCmpDoc", { fg = "#b0b0b0", bg = "#09090a" }) -- docs window text
		vim.api.nvim_set_hl(0, "BlinkCmpDocBorder", { fg = "#2a2a2a" }) -- docs border
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" }) -- don't highlight cursor line globally
		vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch", { fg = "#CBA85E", bg = "NONE", bold = true, nocombine = true }) -- matched chars in label
		vim.api.nvim_set_hl(0, "BlinkCmpLabelMatchDescription", { fg = "NONE", bg = "NONE", bold = false }) -- matched chars in description
	end,
}
