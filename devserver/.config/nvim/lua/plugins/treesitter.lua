return {
    {
	"nvim-treesitter/nvim-treesitter",
	lazy = false, 
	priority = 1000,
	build = ":TSUpdate",
	config = function()
	    require("nvim-treesitter").setup({
	    })

	    require("nvim-treesitter").install({
		"c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",
		"javascript", "typescript", "html", "bash"
	    })

	    vim.api.nvim_create_autocmd("FileType", {
		callback = function()
		    pcall(vim.treesitter.start)
		end,
	    })

	    vim.opt.foldmethod = "expr"
	    vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	    vim.opt.foldenable = false 

	    vim.api.nvim_create_autocmd("FileType", {
		callback = function()
		    local ok, _ = pcall(require, "nvim-treesitter")
		    if ok then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		    end
		end,
	    })
	end
    },
    {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main", -- Also best to use main here if using main treesitter
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
	    -- A. Configure the engine
	    require("nvim-treesitter-textobjects").setup({
		select = {
		    lookahead = true,
		    include_surrounding_whitespace = false,
		},
		move = {
		    set_jumps = true,
		},
	    })

	    -- B. Define Keymaps Explicitly (The "Right" Way)
	    local ts_select = require("nvim-treesitter-textobjects.select")
	    local ts_move = require("nvim-treesitter-textobjects.move")
	    local map = vim.keymap.set

	    -- SELECT mappings (e.g., daf, vif)
	    for _, mode in ipairs({ "x", "o" }) do
		map(mode, "af", function() ts_select.select_textobject("@function.outer", "textobjects") end)
		map(mode, "if", function() ts_select.select_textobject("@function.inner", "textobjects") end)
		map(mode, "ac", function() ts_select.select_textobject("@class.outer", "textobjects") end)
		map(mode, "ic", function() ts_select.select_textobject("@class.inner", "textobjects") end)
		map(mode, "aa", function() ts_select.select_textobject("@parameter.outer", "textobjects") end)
		map(mode, "ia", function() ts_select.select_textobject("@parameter.inner", "textobjects") end)
	    end

	    -- MOVE mappings (e.g., ]m, [m)
	    map({ "n", "x", "o" }, "]m", function() ts_move.goto_next_start("@function.outer", "textobjects") end)
	    map({ "n", "x", "o" }, "[m", function() ts_move.goto_previous_start("@function.outer", "textobjects") end)
	    map({ "n", "x", "o" }, "]M", function() ts_move.goto_next_end("@function.outer", "textobjects") end)
	    map({ "n", "x", "o" }, "[M", function() ts_move.goto_previous_end("@function.outer", "textobjects") end)
	end,
    },
}
