-- ─── Bootstrap lazy.nvim ──────────────────────────────────────────────────────
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo(
			{ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } },
			true,
			{}
		)
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- ─── Leader keys ──────────────────────────────────────────────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- ─── Core config modules ─────────────────────────────────────────────────────-
-- These set up base options, keymaps and autocmds before plugins load.
-- They are core modules that MUST load, so any error here is surfaced instead
-- of being silently swallowed by pcall.
require("config.options")
require("config.keymaps")
require("config.autocmds")

-- ─── Setup lazy.nvim ──────────────────────────────────────────────────────────
require("lazy").setup({
	change_detection = { notify = true },
	spec = {
		-- Import plugin groups (each folder is loaded automatically)
		{ import = "plugins" },
		{ import = "plugins.lsp" },
		{ import = "plugins.ui" },   -- UI plugins (incline, indent, etc.)
		{ import = "plugins.utils" }, -- Utility plugins (harpoon, snacks, etc.)
		{ import = "plugins.git" },  -- Git plugins (neogit, gitsigns)
		{ import = "plugins.latex.plugins" }, -- VimTeX
	},
	-- Automatically check for plugin updates
	checker = { enabled = true },
})
