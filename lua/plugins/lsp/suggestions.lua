return {
	"saghen/blink.cmp",
	version = "*",
	dependencies = {
		"rafamadriz/friendly-snippets",
		"xzbdmw/colorful-menu.nvim",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
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
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		completion = {
			list = {
				selection = {
					preselect = false,
					auto_insert = false,
				},
			},
			menu = {
				border = "rounded",
				draw = {
					-- Organizzazione: Icona | Label (testo principale) | Kind (testo a destra)
					columns = {
						{ "kind_icon" },
						{ "label", gap = 1 },
						{ "kind", gap = 1 },
					},
					components = {
						-- 1. Icona stilizzata
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local icons = {
									Text = "󰉿",
									Method = "󰊕",
									Function = "󰊕",
									Constructor = "",
									Field = "󰜢",
									Variable = "󰆦",
									Class = "󰠱",
									Interface = "",
									Module = "",
									Property = "󰜢",
									Unit = "󰑭",
									Value = "󰎠",
									Enum = "",
									Keyword = "󰌋",
									Snippet = "",
									Color = "󰏘",
									File = "󰈙",
									Reference = "󰈚",
									Folder = "󰉋",
									EnumMember = "",
									Constant = "󰏿",
									Struct = "󰙅",
									Event = "",
									Operator = "󰆕",
									TypeParameter = "󰅲",
								}
								return icons[ctx.kind] or "󰧑"
							end,
							highlight = function(ctx)
								return "BlinkCmpKind" .. ctx.kind
							end,
						},

						-- 2. Testo principale colorato (colorful-menu)
						label = {
							width = { fill = true, max = 60 },
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},

						-- 3. Testo a destra (Tipo di oggetto)
						kind = {
							ellipsis = true,
							width = { min = 10 },
							text = function(ctx)
								return "[" .. ctx.kind .. "]"
							end,
							highlight = function(ctx)
								-- Usiamo un colore più discreto per la parte destra
								return "NonText"
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 250,
				treesitter_highlighting = true,
				window = { border = "rounded" },
			},
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
}
