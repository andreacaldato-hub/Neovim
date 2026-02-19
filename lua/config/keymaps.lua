-- Keymaps are automatically loaded on the VeryLazy event
-- Set leader key to space
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
local opts = { noremap = true, silent = true }
-- Normal paste (keep defaults, but we set explicitly)
vim.keymap.set("n", "P", "P")
vim.keymap.set({ "n", "v" }, "d", '"_d')
vim.keymap.set({ "n", "v" }, "D", '"_D')
vim.keymap.set({ "n", "v" }, "x", '"_x')
vim.keymap.set({ "n", "v" }, "X", '"_X')
vim.keymap.set({ "n", "v" }, "c", '"_c')
vim.keymap.set({ "n", "v" }, "C", '"_C')
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-s>", "<cmd> w <CR>", opts)
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "nzzzv", opts)
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
-- Navigate buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", opts)
vim.keymap.set("n", "<leader>x", ":bd!<CR>", opts) -- close buffer
-- tabs
-- window management
vim.keymap.set("n", "<leader>v", "<C-w>v", opts) -- split window vertically
vim.keymap.set("n", "<leader>o", "<C-w>s", opts) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width & height
vim.keymap.set("n", "<leader>xs", ":close<CR>", opts) -- close current split window
-- Resize with arrows
vim.keymap.set("n", "<Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<Right>", ":vertical resize +2<CR>", opts)
-- Navigate between splits
vim.keymap.set("n", "<C-K>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<C-J>", ":wincmd j<CR>", opts)
vim.keymap.set("n", "<C-H>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<C-L>", ":wincmd l<CR>", opts)
-- toggle line wrapping
vim.keymap.set("n", "<leader>w", "<cmd>set wrap!<CR>", opts)
-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)
-- Keep last yanked when pasting
vim.keymap.set("v", "p", '"_dP', opts)
vim.keymap.set({ "n", "v" }, "x", "d", { noremap = true })
-- path to your terminal emulator
local function run_fzf_tmux(func)
	-- Single-line shell command: run the Zsh function, then exit shell
	local shell_cmd = string.format('zsh -ic "if [ -n \\"$TMUX\\" ]; then %s; else %s; fi"', func, func)

	-- Open a new buffer in full window for terminal
	vim.cmd("enew") -- new empty buffer
	vim.cmd("terminal " .. shell_cmd)
	vim.cmd("startinsert")

	-- Close the buffer automatically when terminal process exits
	vim.cmd([[
    augroup CloseTermOnExit
      autocmd! TermClose <buffer> bd!
    augroup END
  ]])
end

-- Key mappings
-- vim.keymap.set("n", "<M-C-t>", function()
-- 	run_fzf_tmux("fzf-tmux-session")
-- end)
-- vim.keymap.set("n", "<M-C-g>", function()
-- 	run_fzf_tmux("fzf-tmux-gitrepo")
-- end)
-- vim.keymap.set("n", "<M-C-f>", function()
-- 	run_fzf_tmux("fzf-tmux-switch")
-- end)

vim.api.nvim_set_keymap("t", "<leader>q", "<C-\\><C-n>:q<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
	"n",
	"<leader>t",
	":execute 'vsplit term://bash' | :cd %:p:h<CR>",
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap("n", "<leader>h", ":hide<CR>", { noremap = true, silent = true })

-- Set a keybinding for entering Normal mode in terminal
-- Map <Leader>t to open a terminal in the current file's directory
vim.api.nvim_set_keymap("n", "<Leader>t", ":lua OpenTerminalWithCWD()<CR>", { noremap = true, silent = true })

-- Function to open terminal with 'cd' to the current file's directory
function OpenTerminalWithCWD()
	local current_file_dir = vim.fn.expand("%:p:h")

	vim.cmd("botright vsplit")
	vim.fn.termopen(vim.o.shell, { cwd = current_file_dir })

	-- force width AFTER everything settles
	vim.cmd("vertical resize 80")

	vim.cmd("startinsert")
end

-- Set a keybinding for entering Normal mode in terminal
vim.api.nvim_set_keymap("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })
-- Map 'jj' to escape insert mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- Map leader f a to search all files on the system
--vim.api.nvim_set_keymap(
--  "n",
--  "<leader>fh",
--  ":lua require('telescope.builtin').find_files({ "
--    .. "cwd = vim.env.HOME, "
--    .. "hidden = true, "
--    .. "file_ignore_patterns = { '.cache', '.config', '.gnupg', '.local', '.npm', '.pki', '.ssh', 'yay', 'go'} "
--    .. "})<CR>",
--  { noremap = true, silent = true }
--)
--vim.api.nvim_set_keymap(
--  "n",
--  "<leader>fr",
--  ":lua require('telescope.builtin').find_files({cwd='/'})<CR>",
--  { noremap = true, silent = true }
--)
--vim.api.nvim_set_keymap(
--  "n",
--  "<leader>fd",
--  ":lua require('telescope.builtin').find_files({cwd='~/.config/niri'})<CR>",
--  { noremap = true, silent = true }
--)
--vim.api.nvim_set_keymap(
--  "n",
--  "<leader>fc",
--  ":lua require('telescope.builtin').find_files({cwd='~/.config/'})<CR>",
--  { noremap = true, silent = true }
--)
--vim.api.nvim_set_keymap(
--  "n",
--  "<leader>fn",
--  ":lua require('telescope.builtin').find_files({cwd='~/.config/nvim'})<CR>",
--  { noremap = true, silent = true }
--)
--vim.api.nvim_set_keymap(
--  "n",
--  "<leader>fs",
--  ":lua require('telescope.builtin').find_files({cwd='~/.local/share/' , hidden = true })<CR>",
--  { noremap = true, silent = true }
--)
--
--vim.api.nvim_set_keymap(
--  "n",
--  "<leader>ff",
--  ":lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h'), hidden = true })<CR>",
--  { noremap = true, silent = true }
--)

vim.api.nvim_set_keymap("n", "<C-w>", ":set wrap<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<Cmd>TmuxNavigateRight<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<Cmd>TmuxNavigateLeft<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<Cmd>TmuxNavigateUp<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<Cmd>TmuxNavigateDown<CR>", { noremap = true, silent = true })
function OpenTmuxSplit()
	local file_path = vim.fn.expand("%:p:h") -- Get the directory of the current file
	local cmd = "tmux split-window -h -c " .. vim.fn.shellescape(file_path) -- Open tmux split in that directory
	vim.fn.system(cmd)
end

vim.api.nvim_set_keymap("n", "<leader>t", ":lua OpenTmuxSplit()<CR>", { noremap = true, silent = true })
-- lua/user/utils.lua (or similar)
--vim.keymap.set("n", "<leader>b", function()
--  local filepath = vim.fn.expand("%:p")
--  if filepath:match("%.html$") then
--    vim.fn.jobstart({ "firefox", filepath }, { detach = true })
--  else
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Track running live servers
local live_servers = {}

-- Hash dir into unique port between 3000–3999
local function get_port_from_dir(dir)
	local hash = 0
	for i = 1, #dir do
		hash = (hash * 31 + dir:byte(i)) % 10000
	end
	return 3000 + (hash % 1000)
end

-- Check if file is within the directory
local function is_file_in_dir(file, dir)
	return vim.startswith(file, dir)
end

-- Start live-server for current file's dir
map("n", "<leader>bs", function()
	local dir = vim.fn.expand("%:p:h")
	if live_servers[dir] then
		print("Live server already running for: " .. dir)
		return
	end

	local port = get_port_from_dir(dir)
	live_servers[dir] = port

	local cmd = {
		"live-server",
		"--port=" .. port,
		"--quiet",
		"--no-browser",
	}

	vim.fn.jobstart(cmd, {
		cwd = dir,
		detach = true,
		on_exit = function()
			live_servers[dir] = nil
		end,
	})

	print("Live server started at http://localhost:" .. port)
end, opts)

-- Open current file with live server
map("n", "<leader>b", function()
	local file = vim.fn.expand("%:p")
	local dir = vim.fn.expand("%:p:h")
	local file_name = vim.fn.expand("%:t")

	local port = live_servers[dir] or get_port_from_dir(dir)

	if not is_file_in_dir(file, dir) then
		print("File is not inside live server root: " .. dir)
		return
	end

	local url = string.format("http://localhost:%d/%s", port, file_name)
	vim.fn.jobstart({ "firefox", url }, { detach = true })
end, opts)
--    print("Not an HTML file.")
map("n", "<leader>bx", function()
	local dir = vim.fn.expand("%:p:h")
	local port = live_servers[dir]
	if not port then
		print("No live server running for this directory.")
		return
	end
	vim.fn.jobstart({ "pkill", "-f", "live-server.*" .. port }, {
		on_exit = function()
			print("Stopped live server on port " .. port)
			live_servers[dir] = nil
		end,
	})
end, opts)
-- Show currently running live servers
map("n", "<leader>bl", function()
	local count = 0
	for dir, port in pairs(live_servers) do
		print("🟢 " .. dir .. " → http://localhost:" .. port)
		count = count + 1
	end
	if count == 0 then
		print("No live servers running.")
	else
		print(count .. " live server(s) running.")
	end
end, opts)

-- Kill all running live servers
map("n", "<leader>bk", function()
	local count = 0
	for dir, port in pairs(live_servers) do
		vim.fn.jobstart({ "pkill", "-f", "live-server.*" .. port }, {
			on_exit = function()
				print("🛑 Stopped live server on port " .. port)
			end,
		})
		live_servers[dir] = nil
		count = count + 1
	end
	if count == 0 then
		print("No live servers were running.")
	else
		print("Killed " .. count .. " live server(s).")
	end
end, opts)
-- Auto-disable autoindent when pasting
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.opt.paste = false
	end,
})

-- Remap `p` and `P` to paste in 'paste' mode temporarily
vim.keymap.set("n", "p", function()
	local paste = vim.opt.paste:get()
	vim.opt.paste = true
	vim.api.nvim_feedkeys("p", "n", true)
	vim.opt.paste = paste
end, { noremap = true, silent = true })

vim.keymap.set("n", "P", function()
	local paste = vim.opt.paste:get()
	vim.opt.paste = true
	vim.api.nvim_feedkeys("P", "n", true)
	vim.opt.paste = paste
end, { noremap = true, silent = true })
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local file = vim.fn.expand("%:p")
		if file == "" or vim.fn.filereadable(file) == 0 then
			return
		end

		local file_dir = vim.fn.fnamemodify(file, ":h")

		-- get repo + branch cleanly
		local git_root_tbl = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "--show-toplevel" })
		local branch_tbl = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "--abbrev-ref", "HEAD" })

		if vim.v.shell_error ~= 0 or #git_root_tbl == 0 or #branch_tbl == 0 then
			vim.fn.system({ "tmux", "set-option", "-gq", "@nvim_git_info", "" })
			return
		end

		local git_root = vim.fn.trim(git_root_tbl[1])
		local branch = vim.fn.trim(branch_tbl[1])
		local repo = vim.fn.fnamemodify(git_root, ":t")

		local git_info = string.format(" %s:%s", repo, branch)

		-- write cleanly to tmux
		vim.fn.system({ "tmux", "set-option", "-gq", "@nvim_git_info", git_info })
	end,
})
-- Define the function globally (no require needed)
--
-- Tell vim-tmux-navigator NOT to create default keymaps (so you can set your own)
vim.g.tmux_navigator_no_mappings = 1

-- Map Ctrl + h/j/k/l to navigate between tmux panes or vim splits
vim.keymap.set("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
vim.keymap.set("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
vim.keymap.set("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
vim.keymap.set("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })
vim.keymap.set(
	"n",
	"<leader>r",
	":silent !riscv64-elf-gcc -nostdlib -nostartfiles -o %:r.elf % && qemu-riscv64 %:r.elf<CR>",
	{ noremap = true, silent = true }
)
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>xs")
