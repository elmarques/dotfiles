return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local gitsigns = require("gitsigns")
		local keymap = vim.keymap

		gitsigns.setup()

		keymap.set("n", "<leader>gs", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview hunk" })
		keymap.set("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Blame line" })
	end,
}
