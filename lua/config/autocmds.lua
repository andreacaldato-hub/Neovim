-- ─── Autocmds & custom highlight groups ───────────────────────────────────────
-- Default LazyVim autocmds are already set; this file adds extra ones.
-- See: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- Highlight the @operator group with a distinct red
vim.api.nvim_set_hl(0, "@operator", { fg = "#F14C4C" })

-- Generic LspAttach handler: disable semantic tokens for the Lua LSP
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local client = vim.lsp.get_client_by_id(event.data.client_id)

		-- The lua_ls semantic tokens clash with Treesitter highlights on Lua files
		if client.name == "lua_ls" then
			client.server_capabilities.semanticTokensProvider = nil
		end
	end,
})
