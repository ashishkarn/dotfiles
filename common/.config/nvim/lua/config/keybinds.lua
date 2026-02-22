vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Open file explorer" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

vim.keymap.set("n", "<leader>fe", function()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	for i, line in ipairs(lines) do
		if line:match("if err != nil") and vim.fn.foldclosed(i) == -1 then
			vim.api.nvim_win_set_cursor(0, { i, 0 })
			pcall(vim.cmd, "normal! zc")
		end
	end
end, { desc = "Fold all if err != nil" })
