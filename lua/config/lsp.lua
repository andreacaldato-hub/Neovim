-- lua/config/lsp.lua
vim.filetype.add({
	filename = {
		[".bashrc"] = "bash",
		[".zshrc"] = "zsh",
	},
})

-- keymaps when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- go to definition
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) -- find references
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show docs
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- rename symbol
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts) -- code actions
		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts) -- show error popup
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- previous error
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- next error
	end,
})

-- how diagnostics look
vim.diagnostic.config({
	virtual_text = true, -- show error text inline
	signs = true, -- show icons in the gutter
	underline = true, -- underline problematic code
	update_in_insert = false, -- don't show errors while typing
})

vim.env.PATH = vim.fn.stdpath("data") .. "/mason/bin:" .. vim.env.PATH
vim.lsp.set_log_level("off") -- disable logging, speeds up LSP slightly

-- make lsp attach as fast as possible
vim.opt.updatetime = 100 -- default is 4000ms, lower = faster attach

vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" }, -- explicit cmd so it knows where to look
	filetypes = { "lua" }, -- explicit filetype trigger
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
	root_dir = vim.fs.root(0, { ".git", ".luaurc", "default.project.json" }), -- default.project.json is the roblox project file
	settings = {
		["luau-lsp"] = {
			platform = {
				type = "roblox",
			},
		},
	},
})
vim.lsp.enable({ "lua_ls", "pyright", "clangd", "luau_lsp", "bashls" })
