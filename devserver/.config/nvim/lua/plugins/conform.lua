return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
	{ "<leader>cf", function() require("conform").format() end, desc = "Format buffer" },
    },
    opts = {
	formatters_by_ft = {
	    javascript = { "prettierd" },
	    javascriptreact = { "prettierd" },
	    typescript = { "prettierd" },
	    typescriptreact = { "prettierd" },
	    html = { "prettierd" },
	    css = { "prettierd" },
	    json = { "prettierd" },
	    go = { "goimports" },
	},
	format_on_save = {
	    timeout_ms = 500,
	    lsp_fallback = true,
	},
    },
}
