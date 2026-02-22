return {
	{
		"mason-org/mason.nvim",
		opts = {}
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {
			ensure_installed = { "lua_ls", "rust_analyzer", "ts_ls", "gopls", "clangd" },
		},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config('*', { capabilities = capabilities })
			vim.lsp.enable(opts.ensure_installed)

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = args.buf, desc = desc })
					end

					map("gd", vim.lsp.buf.definition, "Go to definition")
					map("gr", vim.lsp.buf.references, "References")
					map("K", vim.lsp.buf.hover, "Hover docs")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code action")
					map("]d", vim.diagnostic.goto_next, "Next diagnostic")
					map("[d", vim.diagnostic.goto_prev, "Prev diagnostic")
					map("<leader>dy", function()
						local diags = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
						if diags[1] then
							vim.fn.setreg('+', diags[1].message)
							vim.notify("Diagnostic copied")
						end
					end, "Copy diagnostic message")
				end,
			})
		end,
	}
}
