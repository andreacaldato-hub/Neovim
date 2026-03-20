return {
	"nickjvandyke/opencode.nvim",
	version = "*",
	lazy = true,
	keys = {
		{ "<C-A>", mode = { "n", "x" }, group = "Opencode" },
		{ "<C-a>", group = "Opencode" },
		{ "<C-x>", mode = { "n", "x" }, group = "Opencode" },
		{ "<leader>o", group = "Opencode", desc = "Toggle opencode (tmux)" },
	},
	dependencies = {
		{
			---@module "snacks"
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {},
				picker = {
					actions = {
						opencode_send = function(...)
							return require("opencode").snacks_picker_send(...)
						end,
					},
					win = {
						input = {
							keys = {
								["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
							},
						},
					},
				},
			},
		},
	},
	config = function()
		vim.o.autoread = true
		vim.api.nvim_set_hl(0, "SnacksInputBorder", { fg = "#1f2329" })
		local oc = require("opencode")

		local function is_oc_running()
			return vim.fn.system("tmux list-windows -F '#{window_name}' 2>/dev/null"):match("opencode") ~= nil
		end

		local function spawn(session_id)
			-- kill any stale opencode processes first
			vim.fn.system("pkill -f '\\.opencode' 2>/dev/null")
			vim.fn.system("tmux kill-window -t opencode 2>/dev/null")
			local cmd = session_id and string.format("opencode --port -s %s; read", session_id)
				or "opencode --port; read"
			vim.fn.system(string.format("tmux new-window -d -n opencode '%s'", cmd))
		end

		vim.g.opencode_opts = {
			server = {
				port = nil,
				start = function()
					spawn(nil)
				end,
				stop = function()
					vim.fn.system("pkill -f '\\.opencode' 2>/dev/null")
					vim.fn.system("tmux kill-window -t opencode 2>/dev/null")
				end,
				toggle = function()
					if is_oc_running() then
						vim.fn.system("pkill -f '\\.opencode' 2>/dev/null")
						vim.fn.system("tmux kill-window -t opencode 2>/dev/null")
					else
						spawn(nil)
					end
				end,
			},
		}

		vim.keymap.set({ "n", "x" }, "<C-a>", function()
			if not is_oc_running() then
				spawn(nil)
				vim.defer_fn(function()
					oc.ask("", { submit = true })
				end, 2000)
			else
				oc.ask("", { submit = true })
			end
		end, { desc = "Ask opencode…" })

		vim.keymap.set({ "n", "x" }, "<C-x>", function()
			oc.select()
		end, { desc = "Execute opencode action…" })

		vim.keymap.set("n", "<leader>o", function()
			if is_oc_running() then
				vim.fn.system("pkill -f '\\.opencode' 2>/dev/null")
				vim.fn.system("tmux kill-window -t opencode 2>/dev/null")
			else
				spawn(nil)
			end
		end, { desc = "Toggle opencode (tmux)" })

		vim.keymap.set({ "n", "x" }, "go", function()
			return oc.operator("@this ")
		end, { desc = "Add range to opencode", expr = true })

		vim.keymap.set("n", "goo", function()
			return oc.operator("@this ") .. "_"
		end, { desc = "Add line to opencode", expr = true })

		vim.keymap.set("n", "<S-C-u>", function()
			oc.command("session.half.page.up")
		end, { desc = "Scroll opencode up" })

		vim.keymap.set("n", "<S-C-d>", function()
			oc.command("session.half.page.down")
		end, { desc = "Scroll opencode down" })
	end,
}
