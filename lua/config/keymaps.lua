-- ─── Defaults ───────────────────────────────────────────────────────────────────
-- Keymaps are automatically loaded on the VeryLazy event
local opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- Disable the default <Space> mapping
map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- ─── Delete / Change (black hole register) ──────────────────────────────────────
-- Send deletes/changes to the black hole register so nothing lands in the #0 register
map({ "n", "v" }, "d", '"_d')
map({ "n", "v" }, "D", '"_D')
map({ "n", "v" }, "c", '"_c')
map({ "n", "v" }, "C", '"_C')
map({ "n", "v" }, "x", '"_x')
map({ "n", "v" }, "X", '"_X')

-- ─── Paste ───────────────────────────────────────────────────────────────────────
-- Normal mode: always paste from system clipboard
-- map("n", "p", '"+p', opts)
-- map("n", "P", '"+P', opts)
-- map("x", "dp", '"_dP', { desc = "Delete and paste" })
vim.keymap.set({ "n", "v" }, "<leader>p", [["_dP]])

-- Visual mode: replace selection with clipboard, force linewise, no yank
map("x", "p", function()
	local text = vim.fn.getreg("+")
	local lines = vim.split(text, "\n")
	-- remove trailing empty line if present
	if lines[#lines] == "" then
		table.remove(lines)
	end
	vim.cmd('normal! "_d')
	vim.api.nvim_put(lines, "l", false, true)
end)

-- ─── Misc ───────────────────────────────────────────────────────────────────────
map("n", "J", "mzJ`z") -- join line, keep cursor position
map("n", "Q", "<nop>") -- disable Ex mode
map("n", "<Esc>", "<cmd>noh<CR>")
map("n", "n", "nzzzv", opts) -- center search results
map("n", "N", "Nzzzv", opts)
map("n", "<C-d>", "<C-d>zz", opts) -- center half-page jumps
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-s>", "<cmd>w<CR>", opts) -- save file

-- ─── Buffers ────────────────────────────────────────────────────────────────────
map("n", "<Tab>", ":bnext<CR>", opts)
map("n", "<S-Tab>", ":bprevious<CR>", opts)
map("n", "<leader>x", ":bd!<CR>", opts) -- close buffer (no prompt)

-- ─── Window management ──────────────────────────────────────────────────────────
map("n", "<leader>v", "<C-w>v", opts) -- vertical split
map("n", "<leader>o", "<C-w>s", opts) -- horizontal split
map("n", "<leader>se", "<C-w>=", opts) -- equalize windows
map("n", "<leader>w", "<cmd>set wrap!<CR>", opts) -- toggle wrap

-- ─── Resize ─────────────────────────────────────────────────────────────────────
map("n", "<Up>", ":resize +2<CR>", opts)
map("n", "<Down>", ":resize -2<CR>", opts)
map("n", "<Left>", ":vertical resize -2<CR>", opts)
map("n", "<Right>", ":vertical resize +2<CR>", opts)

-- ─── Indenting (stay in visual mode) ────────────────────────────────────────────
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- ─── Move lines ─────────────────────────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- ─── Tmux navigation ────────────────────────────────────────────────────────────
vim.g.tmux_navigator_no_mappings = 1
map("n", "<C-h>", ":TmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", ":TmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", ":TmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", ":TmuxNavigateRight<CR>", { silent = true })

-- ─── Terminal ───────────────────────────────────────────────────────────────────
map("t", "<Esc>", [[<C-\><C-n>]], opts)
map("t", "<leader>q", "<C-\\><C-n>:q<CR>", opts)

-- Open a horizontal tmux split in the current file's directory
function OpenTmuxSplit()
	local file_path = vim.fn.expand("%:p:h")
	local cmd = "tmux split-window -h -c " .. vim.fn.shellescape(file_path)
	vim.fn.system(cmd)
end

map("n", "<leader>t", ":lua OpenTmuxSplit()<CR>", opts)

-- ─── Live server ────────────────────────────────────────────────────────────────
local live_servers = {}

local function get_port_from_dir()
	return 3000
end

-- Start a live server for the current directory
map("n", "<leader>bs", function()
	local dir = vim.fn.expand("%:p:h")
	if live_servers[dir] then
		print("Live server already running for: " .. dir)
		return
	end
	local port = get_port_from_dir()
	live_servers[dir] = port
	vim.fn.jobstart({ "live-server", "--port=" .. port, "--no-browser" }, {
		cwd = dir,
		detach = true,
		on_exit = function()
			live_servers[dir] = nil
			print("Live server stopped for: " .. dir)
		end,
	})
	print("Live server started at http://localhost:" .. port)
end, opts)

-- Open the current file in Firefox via the running live server
map("n", "<leader>b", function()
	local file = vim.fn.expand("%:t")
	local dir = vim.fn.expand("%:p:h")
	local port = live_servers[dir]
	if not port then
		print("No live server running, start with <leader>bs")
		return
	end
	vim.fn.jobstart({ "firefox", string.format("http://localhost:%d/%s", port, file) }, { detach = true })
end, opts)

-- Stop the live server for the current directory
map("n", "<leader>bx", function()
	local dir = vim.fn.expand("%:p:h")
	local port = live_servers[dir]
	if not port then
		print("No live server running for this directory.")
		return
	end
	vim.fn.jobstart({ "pkill", "-f", "live-server.*" .. port }, {
		on_exit = function()
			live_servers[dir] = nil
			print("Stopped live server on port " .. port)
		end,
	})
end, opts)

-- ─── Auto reload live server on save ────────────────────────────────────────────
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*.html", "*.css", "*.js" },
	callback = function()
		local dir = vim.fn.expand("%:p:h")
		if live_servers[dir] then
			vim.fn.writefile({}, dir .. "/.reload")
		end
	end,
})

-- ─── Git info in tmux ───────────────────────────────────────────────────────────
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		local file = vim.fn.expand("%:p")
		if file == "" or vim.fn.filereadable(file) == 0 then
			return
		end
		local file_dir = vim.fn.fnamemodify(file, ":h")
		local git_root_tbl = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "--show-toplevel" })
		local branch_tbl = vim.fn.systemlist({ "git", "-C", file_dir, "rev-parse", "--abbrev-ref", "HEAD" })
		if vim.v.shell_error ~= 0 or #git_root_tbl == 0 or #branch_tbl == 0 then
			vim.fn.system({ "tmux", "set-option", "-gq", "@nvim_git_info", "" })
			return
		end
		local repo = vim.fn.fnamemodify(vim.fn.trim(git_root_tbl[1]), ":t")
		local branch = vim.fn.trim(branch_tbl[1])
		vim.fn.system({ "tmux", "set-option", "-gq", "@nvim_git_info", string.format(" %s:%s", repo, branch) })
	end,
})

-- ─── RISCV ──────────────────────────────────────────────────────────────────────
map("n", "<leader>r", ":silent !riscv64-elf-gcc -nostdlib -nostartfiles -o %:r.elf % && qemu-riscv64 %:r.elf<CR>", opts)

-- ─── Cleanup conflicting LazyVim defaults ──────────────────────────────────────
-- Remove the LazyVim default split-to-the-right mapping, if it exists
pcall(vim.keymap.del, "n", "<leader>xs")
map("n", "<leader>?", function()
	require("telescope.builtin").keymaps({
		modes = { "n", "v", "x", "i", "o", "t" },
	})
end, { desc = "Search keymaps" })

-- Run the current MATLAB line in a floating toggleterm
map("n", "<leader>mR", function()
	local line = vim.api.nvim_get_current_line()
	require("toggleterm").exec(line)
end, { desc = "Run MATLAB line in float" })

-- Compile and run the current C file with raylib
map("n", "<leader>cC", function()
	local file = vim.fn.expand("%")
	local output = vim.fn.expand("%:r")

	vim.cmd("!" .. string.format("gcc %s -o %s $(pkg-config --cflags --libs raylib) && ./%s", file, output, output))
end, { desc = "Compile and run current C file" })
