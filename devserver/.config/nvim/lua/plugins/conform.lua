return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
	{ "<leader>cf", function() require("conform").format() end, desc = "Format buffer" },
    },
    opts = {
	formatters_by_ft = {
	    javascript = { "prettier" },
	    javascriptreact = { "prettier" },
	    typescript = { "prettier" },
	    typescriptreact = { "prettier" },
	    html = { "prettier" },
	    css = { "prettier" },
	    json = { "prettier" },
	    go = { "goimports" },
	    c = { "clang-format" },
	    cpp = { "clang-format" },
	},
	format_on_save = {
	    timeout_ms = 500,
	    lsp_fallback = true,
	},
    },
}
