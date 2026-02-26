return {
	"stevearc/overseer.nvim",
	keys = {
		{
			"<leader>or",
			function()
				local overseer = require("overseer")
				-- 1. Start the task
				overseer.run_template({ name = "C: Full Diagnostics (Leak + Speed)" }, function(task)
					if task then
						-- 2. Immediately open the float as soon as the task object exists
						overseer.run_action(task, "open float")
					end
				end)
			end,
			desc = "Profiler: Run & Auto-Float",
		},
		{
			"<leader>ov",
			function()
				local overseer = require("overseer")
				local tasks = overseer.list_tasks({ recent = true })
				if #tasks > 0 then
					overseer.run_action(tasks[1], "open float")
				end
			end,
			desc = "Profiler: Manual Toggle",
		},
	},
	config = function()
		local overseer = require("overseer")

		overseer.setup({
			templates = { "builtin" },
			task_win = { border = "rounded" },
			actions = {
				["open float"] = {
					desc = "open in a large floating window",
					run = function(task)
						local bufnr = task:get_bufnr()
						if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
							local width = math.floor(vim.o.columns * 0.8)
							local height = math.floor(vim.o.lines * 0.8)
							vim.api.nvim_open_win(bufnr, true, {
								relative = "editor",
								width = width,
								height = height,
								col = math.floor((vim.o.columns - width) / 2),
								row = math.floor((vim.o.lines - height) / 2),
								border = "rounded",
								style = "minimal",
							})
							-- Auto-scroll to bottom as output comes in
							vim.api.nvim_command("normal! G")
						end
					end,
				},
			},
		})

		overseer.register_template({
			name = "C: Full Diagnostics (Leak + Speed)",
			builder = function()
				local file = vim.fn.expand("%:p")
				local outfile = vim.fn.expand("%:p:r")
				local BLUE, GREEN, YELLOW, BOLD, RESET = "\\e[1;34m", "\\e[1;32m", "\\e[1;33m", "\\e[1m", "\\e[0m"

				return {
					cmd = { "bash", "-c" },
					args = {
						string.format(
							"gcc -g -O2 '%s' -o '%s' && "
								.. "echo -e '%s%s[1/2] MEMORY & LEAK ANALYSIS%s' && "
								.. "valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes '%s' && "
								.. "echo -e '\\n%s%s[2/2] EXECUTION SPEED ANALYSIS%s' && "
								.. "valgrind --tool=callgrind --callgrind-out-file=call.out '%s' > /dev/null 2>&1 && "
								.. "echo -e '%sTop Bottleneck Lines (Instruction Count):%s' && "
								.. "callgrind_annotate --auto=yes call.out | head -n 25 && "
								.. "rm call.out '%s'",
							file,
							outfile,
							BLUE,
							BOLD,
							RESET,
							outfile,
							GREEN,
							BOLD,
							RESET,
							outfile,
							YELLOW,
							RESET,
							outfile
						),
					},
					components = {
						{ "on_output_summarize", max_lines = 100 },
						"on_exit_set_status",
						"on_complete_notify",
						{ "on_output_quickfix", open = true },
					},
				}
			end,
			condition = { filetype = { "c", "cpp" } },
		})
	end,
}
