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

vim.api.nvim_create_autocmd("BufNewFile", {
	pattern = "*.java",
	callback = function()
		local filepath = vim.fn.expand("%:p:h")

		-- 1. Estrae il percorso partendo da src/main/java/ oppure semplicemente da src/
		local package_path = filepath:match("src/main/java/(.+)") or filepath:match("src/(.+)")

		if package_path then
			-- 2. Converte le slash (/) nei punti (.) convenzionali di Java
			local package_name = package_path:gsub("/", ".")
			local class_name = vim.fn.expand("%:t:r")

			-- 3. Scrive l'intestazione del file nel nuovo buffer
			vim.api.nvim_buf_set_lines(0, 0, 0, false, {
				"package " .. package_name .. ";",
				"",
				"public class " .. class_name .. " {",
				"    ",
				"}",
			})

			-- 4. Posiziona il cursore all'interno della classe
			vim.api.nvim_win_set_cursor(0, { 4, 4 })
		end
	end,
})

vim.api.nvim_create_autocmd({ "VimEnter", "DirChanged" }, {
	pattern = "*",
	callback = function()
		vim.fn.system({ "tmux", "chdir", vim.fn.getcwd() })
	end,
})
