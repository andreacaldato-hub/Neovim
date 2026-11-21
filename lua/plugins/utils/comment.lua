-- Commenting plugin.
--
-- Keymaps (defaults di Comment.nvim):
--   gcc   toggle commento sulla riga corrente
--   gc    toggle commento su un motion / selezione visuale (linewise)
--   gbc   toggle commento a blocco sulla riga corrente
--   gb    toggle commento a blocco su un motion / selezione visuale
--   gco   aggiungi un commento sotto
--   gcO   aggiungi un commento sopra
--   gcA   aggiungi un commento a fine riga
--
-- Il pre_hook usa ts_context_commentstring per lo stile giusto in base al
-- linguaggio (tree-sitter). Se il parser manca o fallisce, ripiega sul
-- commentstring nativo di Neovim: così non si blocca mai, nemmeno su Neovim
-- 0.12 dove get_parser() ritorna nil invece di lanciare un errore.
local function create_pre_hook()
	local U = require("Comment.utils")

	return function(ctx)
		-- Linewise -> __default, blockwise -> __multiline
		local key = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

		local location = nil
		if ctx.ctype == U.ctype.blockwise then
			location = { ctx.range.srow - 1, ctx.range.scol }
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = require("ts_context_commentstring.utils").get_visual_start_location()
		end

		local ok, cstr = pcall(require("ts_context_commentstring").calculate_commentstring, {
			key = key,
			location = location,
		})

		if ok and cstr then
			return cstr
		end

		-- Fallback: commentstring nativo (funziona anche senza parser tree-sitter)
		return vim.bo.commentstring
	end
end

return {
	"numToStr/Comment.nvim",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	config = function()
		-- Stile dei commenti per ogni linguaggio tree-sitter.
		-- __default = commento di riga, __multiline = commento a blocco.
		require("ts_context_commentstring").setup({
			enable_autocmd = false, -- ricalcola solo quando Comment.nvim lo chiede

			languages = {
				python = { __default = "# %s", __multiline = '""" %s """' },
				lua = { __default = "-- %s", __multiline = "--[[ %s ]]" },
				c = { __default = "// %s", __multiline = "/* %s */" },
				cpp = { __default = "// %s", __multiline = "/* %s */" },
				java = { __default = "// %s", __multiline = "/* %s */" },
				kotlin = { __default = "// %s", __multiline = "/* %s */" },
				javascript = { __default = "// %s", __multiline = "/* %s */" },
				typescript = { __default = "// %s", __multiline = "/* %s */" },
				c_sharp = { __default = "// %s", __multiline = "/* %s */" },
			},
		})

		require("Comment").setup({
			padding = true, -- spazio tra il marker e il testo
			sticky = true, -- mantiene la posizione del cursore in normal mode
			mappings = {
				basic = true, -- gcc, gbc, gc{motion}, gb{motion}
				extra = true, -- gco, gcO, gcA
			},
			pre_hook = create_pre_hook(),
		})
	end,
}
