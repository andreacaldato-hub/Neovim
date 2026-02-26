return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- UI and Visuals
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-tree/nvim-web-devicons",

		-- Tool Management
		"williamboman/mason.nvim",
		"jay-babu/mason-nvim-dap.nvim",

		-- Language Specific Helpers
		"leoluz/nvim-dap-go",
		"mfussenegger/nvim-dap-python",
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
		},
		"mxsdev/nvim-dap-vscode-js",
		"jbyuki/one-small-step-for-vimkind",
	},
	keys = {
		{
			"<leader>dS",
			function()
				require("dap").continue()
			end,
			desc = "Debug: Start/Continue",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>dsi",
			function()
				require("dap").step_into()
			end,
			desc = "Debug: Step Into",
		},
		{
			"<leader>dso",
			function()
				require("dap").step_over()
			end,
			desc = "Debug: Step Over",
		},
		{
			"<leader>dsO",
			function()
				require("dap").step_out()
			end,
			desc = "Debug: Step Out",
		},
		{
			"<leader>dtu",
			function()
				require("dapui").toggle()
			end,
			desc = "Debug: Toggle UI",
		},
		{
			"<leader>dl",
			function()
				require("osv").launch({ port = 8086 })
			end,
			desc = "Debug: Start Lua Server",
		},
		{
			"<leader>dq",
			function()
				require("dap").terminate()
			end,
			desc = "Debug: Terminate",
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		require("nvim-dap-virtual-text").setup({})

		------------------------------------------------------------------------
		-- 1. Icons & Aesthetics (The "Beautiful" Part)
		------------------------------------------------------------------------
		vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
		vim.api.nvim_set_hl(0, "DapStopped", { fg = "#98c379", bold = true })
		vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2e3b3b" }) -- Subtle highlight for the current line

		local icons = {
			Breakpoint = "",
			BreakpointCondition = "",
			BreakpointRejected = "",
			LogPoint = "",
			Stopped = "",
		}

		for type, icon in pairs(icons) do
			local tp = "Dap" .. type
			local hl = (type == "Stopped") and "DapStopped" or "DapBreakpoint"
			local line_hl = (type == "Stopped") and "DapStoppedLine" or ""
			vim.fn.sign_define(tp, { text = icon, texthl = hl, linehl = line_hl, numhl = hl })
		end

		------------------------------------------------------------------------
		-- 2. Mason & Adapter Handlers
		------------------------------------------------------------------------
		require("mason-nvim-dap").setup({
			automatic_installation = true,
			ensure_installed = { "delve", "python", "codelldb" },
			handlers = {
				function(config)
					require("mason-nvim-dap").default_setup(config)
				end,
				codelldb = function(config)
					config.adapters = {
						type = "server",
						port = "${port}",
						executable = {
							command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
							args = { "--port", "${port}" },
						},
					}
					require("mason-nvim-dap").default_setup(config)
				end,
			},
		})

		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = dapui.open
		dap.listeners.before.event_terminated["dapui_config"] = dapui.close
		dap.listeners.before.event_exited["dapui_config"] = dapui.close

		------------------------------------------------------------------------
		-- 3. Language Configurations
		------------------------------------------------------------------------

		-- C / C++ / Rust
		dap.configurations.c = {
			{
				name = "Launch file",
				type = "codelldb",
				request = "launch",
				program = function()
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}
		dap.configurations.cpp = dap.configurations.c
		dap.configurations.rust = dap.configurations.c

		-- Lua
		dap.adapters.nlua = function(callback, config)
			callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
		end
		dap.configurations.lua = {
			{ type = "nlua", request = "attach", name = "Attach to running Neovim instance" },
		}

		-- JavaScript / TypeScript
		require("dap-vscode-js").setup({
			debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
			adapters = { "pwa-node", "pwa-chrome", "node-terminal" },
		})

		for _, language in ipairs({ "typescript", "javascript" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
			}
		end

		require("dap-python").setup("python3")
		require("dap-go").setup()
	end,
}
