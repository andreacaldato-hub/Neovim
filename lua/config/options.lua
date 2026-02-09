-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"
vim.opt.shell = "/usr/bin/zsh"
vim.opt.nu = true
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.number = true
vim.opt.title = true
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.equalalways = false
vim.opt.colorcolumn = "100"
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.cmdheight = 0
vim.opt.laststatus = 0
vim.opt.expandtab = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.swapfile = false
vim.opt.softtabstop = 4
vim.opt.wrap = false
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" })
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.splitkeep = "cursor"
vim.opt.mouse = ""

vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 10

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"
vim.g.vimtex_view_general_options = "--synctex-forward @line:@col:@tex --no-guess"

vim.api.nvim_create_user_command("LatexBuild", function()
    local tex_file = vim.fn.expand("%:p")
    local pdf_file = tex_file:gsub("%.tex$", ".pdf")

    -- Compile the .tex file
    vim.cmd("VimtexCompile")

    -- Open Zathura in a Kitty split
    vim.fn.system("kitty --detach zathura " .. pdf_file)
end, {})
-- Function to compile and open PDF in vertical split
