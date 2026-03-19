return {
	-- ─── Neogit ───────────────────────────────────────────────────────────────
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		keys = {
			-- Open the full Neogit status UI
			{
				"<leader>gg",
				function()
					require("neogit").open({ kind = "tab", cwd = vim.fn.expand("%:p:h") })
				end,
				desc = "Open Neogit",
			},

			-- Save your staged changes as a snapshot in the git history
			{
				"<leader>gc",
				function()
					require("neogit").open({ "commit" })
				end,
				desc = "Git Commit",
			},

			-- Upload your local commits to the remote repository
			{
				"<leader>gp",
				function()
					require("neogit").open({ "push" })
				end,
				desc = "Git Push",
			},

			-- Download and integrate remote commits into your current branch
			{
				"<leader>gl",
				function()
					require("neogit").open({ "pull" })
				end,
				desc = "Git Pull",
			},

			-- Create, switch, rename or delete branches
			{
				"<leader>gb",
				function()
					require("neogit").open({ "branch" })
				end,
				desc = "Git Branch",
			},

			-- Reapply your commits on top of another branch, rewriting history
			{
				"<leader>gR",
				function()
					require("neogit").open({ "rebase" })
				end,
				desc = "Git Rebase",
			},

			-- Download remote changes without merging them into your branch
			{
				"<leader>gf",
				function()
					require("neogit").open({ "fetch" })
				end,
				desc = "Git Fetch",
			},

			-- Combine another branch into your current one, creating a merge commit
			{
				"<leader>gm",
				function()
					require("neogit").open({ "merge" })
				end,
				desc = "Git Merge",
			},

			-- Temporarily shelve uncommitted changes to work on something else
			{
				"<leader>gS",
				function()
					require("neogit").open({ "stash" })
				end,
				desc = "Git Stash",
			},

			-- Browse every change ever made to the current file, commit by commit
			{ "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", desc = "File History" },

			-- Browse the full commit history of the entire repo
			{ "<leader>gH", "<cmd>DiffviewFileHistory<CR>", desc = "Repo History" },

			-- Close the diffview panel
			{ "<leader>gx", "<cmd>DiffviewClose<CR>", desc = "Close Diffview" },
		},
		config = function()
			require("neogit").setup({
				kind = "tab",
				signs = {
					hunk = { "", "" },
					item = { "", "" },
					section = { "", "" },
				},
				integrations = {
					diffview = true,
				},
				commit_editor = {
					kind = "tab",
				},
			})
		end,
	},

	-- ─── Gitsigns ─────────────────────────────────────────────────────────────
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "|" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "+" },
					change = { text = "|" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged_enable = true,
				signcolumn = true,
				numhl = true,
				linehl = false,
				word_diff = false,
				watch_gitdir = { follow_files = true },
				auto_attach = true,
				attach_to_untracked = true,
				current_line_blame = false,
				sign_priority = 6,
				update_debounce = 100,
				max_file_length = 40000,
				preview_config = {
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
				on_attach = function(bufnr)
					local gitsigns = require("gitsigns")
					local function map(mode, l, r, opts)
						opts = opts or {}
						opts.buffer = bufnr
						vim.keymap.set(mode, l, r, opts)
					end

					-- Jump to next changed hunk in the file
					map("n", "]c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "]c", bang = true })
						else
							gitsigns.nav_hunk("next")
						end
					end)

					-- Jump to previous changed hunk in the file
					map("n", "[c", function()
						if vim.wo.diff then
							vim.cmd.normal({ "[c", bang = true })
						else
							gitsigns.nav_hunk("prev")
						end
					end)

					-- Stage the hunk under the cursor
					map("n", "<leader>gs", gitsigns.stage_hunk)

					-- Discard the hunk under the cursor back to what's in the index
					map("n", "<leader>rh", gitsigns.reset_hunk)

					-- Stage a range of lines as a hunk (visual mode)
					map("v", "<leader>hs", function()
						gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)

					-- Discard a range of lines back to what's in the index (visual mode)
					map("v", "<leader>rvr", function()
						gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
					end)

					-- Discard every hunk in the entire buffer back to HEAD
					map("n", "<leader>gX", gitsigns.reset_buffer)

					-- Preview the hunk diff inline below the current line
					map("n", "<leader>ph", gitsigns.preview_hunk_inline)

					-- Diff the current file against the index (staged version)
					map("n", "<leader>gd", gitsigns.diffthis)

					-- Diff the current file against the last commit
					map("n", "<leader>gD", function()
						gitsigns.diffthis("~")
					end)

					-- Send all changed hunks across every file to the quickfix list
					map("n", "<leader>gQ", function()
						gitsigns.setqflist("all")
					end)

					-- Send changed hunks in the current file to the quickfix list
					map("n", "<leader>gq", gitsigns.setqflist)

					-- Select the hunk under the cursor as a text object
					map({ "o", "x" }, "ih", gitsigns.select_hunk)
				end,
			})
		end,
	},
}
