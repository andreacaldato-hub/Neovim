-- ─── Core options ─────────────────────────────────────────────────────────────
-- mapleader is set in config/lazy.lua

vim.opt.clipboard = "unnamedplus" -- use the system clipboard
vim.opt.shell = "/usr/bin/zsh"

-- ─── Line numbers ─────────────────────────────────────────────────────────────
vim.opt.nu = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- ─── Encoding ─────────────────────────────────────────────────────────────────
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

-- ─── Display ──────────────────────────────────────────────────────────────────
vim.opt.title = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.opt.equalalways = false
vim.opt.colorcolumn = "100"
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 8
vim.opt.breakindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.fillchars = { eob = " " }

-- Reference highlighting (line background removed, see below)
vim.opt.mouse = ""

-- ─── Editing ──────────────────────────────────────────────────────────────────
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 4
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.swapfile = false
vim.opt.backup = false

-- File path / search helpers
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })

-- ─── Search ───────────────────────────────────────────────────────────────────
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- ─── Timing ───────────────────────────────────────────────────────────────────
vim.opt.updatetime = 50
vim.opt.inccommand = "split"
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 9

-- ─── Formatting ───────────────────────────────────────────────────────────────
-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- ─── VimTeX globals ───────────────────────────────────────────────────────────
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_general_options = "--synctex-forward @line:@col:@tex --no-guess"

-- ─── Custom commands ──────────────────────────────────────────────────────────
-- Compile the current .tex file and open the resulting PDF in Zathura
vim.api.nvim_create_user_command("LatexBuild", function()
	local tex_file = vim.fn.expand("%:p")
	local pdf_file = tex_file:gsub("%.tex$", ".pdf")

	-- Compile the .tex file
	vim.cmd("VimtexCompile")

	-- Open Zathura in a Kitty split
	vim.fn.system("kitty --detach zathura " .. pdf_file)
end, {})

-- ─── Highlights ───────────────────────────────────────────────────────────────
-- Flash the visual selection on yank so it's easy to see what was copied
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({
			higroup = "Visual", -- reuse the visual selection color
			timeout = 150,
			priority = 250, -- higher than colorizer's default (100)
		})
	end,
})
-- Search / incremental search styling
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#ffb454", fg = "#0a0e14" })
