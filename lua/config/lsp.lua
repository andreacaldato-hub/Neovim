-- ─── LSP configuration ─────────────────────────────────────────────────────────

-- Custom filetype detection
vim.filetype.add({
	filename = {
		[".bashrc"] = "bash",
		[".zshrc"] = "zsh",
	},
})

-- ─── Keymaps on LSP attach ─────────────────────────────────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", function()
			vim.lsp.buf.hover({ border = "rounded" })
		end, opts)

		-- gd/gD/gr/gi/gI/gy/gai/gao sono gestiti globalmente dalle Snacks
		-- pickers (lua/plugins/utils/snacks.lua) con output a lista+preview.
		-- Non li ridefiniamo qui per non oscurarli: il buffer-local `gr` senza
		-- nowait causava attesa, perche' `gr` e' prefisso dei comandi registri
		-- built-in (gra, grr, grt, ...).
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

		-- Diagnostic popup (<leader>e) with an explicit rounded border
		vim.keymap.set("n", "<leader>e", function()
			vim.diagnostic.open_float({ border = "rounded" })
		end, opts)

		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
	end,
})

-- ─── Diagnostic display ────────────────────────────────────────────────────────
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	float = { border = "rounded" }, -- rounded border on diagnostic floating windows
})

-- ─── Rounded borders per-call ─────────────────────────────────────────────────
-- Da Neovim 0.11+ i handler globali (es. vim.lsp.handlers["textDocument/hover"])
-- non vengono piu' usati da |vim.lsp.buf.hover()|: il bordo va passato come
-- opzione direttamente nella chiamata (vedi il keymap di K qui sopra).

-- ─── Environment & performance ─────────────────────────────────────────────────
vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
vim.lsp.log.set_level("off")
-- NOTE: `updatetime` is set in config/options.lua (50ms)

-- ─── LSP server definitions ────────────────────────────────────────────────────
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
})

vim.lsp.config("bashls", {
	cmd = { "bash-language-server" },
	filetypes = { "sh", "bash", "zsh" },
})

vim.lsp.config("clangd", {
	cmd = { "clangd" },
	filetypes = { "c", "cpp" },
})

vim.lsp.config("luau_lsp", {
	cmd = {
		"luau-lsp",
		"lsp",
		"--definitions=" .. vim.fn.expand("~/.roblox/globalTypes.d.luau"),
		"--docs=" .. vim.fn.expand("~/.roblox/en-us.json"),
	},
	filetypes = { "luau" },
	-- root_markers resolve the workspace root per-buffer (searching upward),
	-- unlike root_dir = vim.fs.root(0, ...) which is evaluated once at load time.
	root_markers = { ".git", ".luaurc", "default.project.json" },
	settings = {
		["luau-lsp"] = {
			platform = {
				type = "roblox",
			},
		},
	},
})

vim.lsp.config("texlab", {
	cmd = { "texlab" },
	filetypes = { "tex" },
})

-- ─── Enable the configured LSP servers ─────────────────────────────────────────
vim.lsp.enable({ "lua_ls", "pyright", "clangd", "luau_lsp", "bashls", "texlab" })
