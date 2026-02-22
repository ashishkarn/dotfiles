return {
	{
		"mfussenegger/nvim-dap",
		config = function()
			local dap = require("dap")
			vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "DAP Continue" })
			vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "DAP Step Over" })
			vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "DAP Step Into" })
			vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "DAP Step Out" })
			vim.keymap.set("n", "<F8>", function() dap.terminate() end, { desc = "DAP Terminate" })
			vim.keymap.set("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" })
		end,
	},
	{
		"leoluz/nvim-dap-go",
		dependencies = "mfussenegger/nvim-dap",
		config = function()
			require("dap-go").setup()
		end,
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup()

			vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "DAP Toggle UI" })

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
