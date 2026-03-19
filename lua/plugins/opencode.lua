return {
	"nickjvandyke/opencode.nvim",
	version = "*",
	lazy = true,
	keys = {
		{ "<C-A>", mode = { "n", "x" }, group = "Opencode" },
		{ "<C-a>", group = "Opencode" },
		{ "<C-x>", mode = { "n", "x" }, group = "Opencode" },
		{ "<leader>o", mode = { "n", "t" }, group = "Opencode" },
	},
	dependencies = {
		{
			-- `snacks.nvim` integration is recommended, but optional
			---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisenseop
			"folke/snacks.nvim",
			optional = true,
			opts = {
				input = {}, -- Enhances `ask()`
				picker = { -- Enhances `select()`
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
		vim.g.opencode_opts = {}
		vim.o.autoread = true

		local oc = require("opencode")

		vim.keymap.set({ "n", "x" }, "<C-A>", function()
			oc.ask("@this: ", { submit = true })
		end, { desc = "Ask opencode…" })
		vim.keymap.set("n", "<C-a>", function()
			oc.ask("", { submit = true })
		end, { desc = "Ask opencode (free prompt)…" })
		vim.keymap.set({ "n", "x" }, "<C-x>", function()
			oc.select()
		end, { desc = "Execute opencode action…" })
		vim.keymap.set({ "n", "t" }, "<leader>o", function()
			oc.toggle()
		end, { desc = "Toggle opencode" })
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

		-- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
		vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
		vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
	end,
}
