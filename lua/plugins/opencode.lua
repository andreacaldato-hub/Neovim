return {
	"nickjvandyke/opencode.nvim",
	version = "*",
	lazy = true,
	keys = {
		{ "<C-A>", mode = { "n", "x" }, group = "Opencode" },
		{ "<C-a>", group = "Opencode" },
		{ "<C-x>", mode = { "n", "x" }, group = "Opencode" },
		{ "<leader>o", mode = { "n", "t" }, group = "Opencode", desc = "Toggle opencode (tmux)" },
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

		local tmux_win = "opencode"

		local function is_running()
			return vim.fn.system("tmux list-windows -F '#{window_name}' 2>/dev/null"):match(tmux_win) ~= nil
		end

		vim.g.opencode_opts = {
			server = {
				port = nil,
				start = function()
					vim.fn.system("tmux new-window -n " .. tmux_win .. " 'opencode --port; read'")
				end,
				stop = function()
					vim.fn.system("tmux kill-window -t " .. tmux_win .. " 2>/dev/null")
				end,
				toggle = function()
					if is_running() then
						vim.g.opencode_opts.server.stop()
					else
						vim.g.opencode_opts.server.start()
					end
				end,
			},
		}

		local oc = require("opencode")

		vim.keymap.set({ "n", "x" }, "<C-a>", function()
			oc.ask("", { submit = true })
		end, { desc = "Ask opencode…" })
		vim.keymap.set({ "n", "x" }, "<C-x>", function()
			oc.select()
		end, { desc = "Execute opencode action…" })
		vim.keymap.set({ "n", "t" }, "<leader>o", function()
			oc.toggle()
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
