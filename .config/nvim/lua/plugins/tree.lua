return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local tree = require("nvim-tree")
		local keymap = vim.keymap

		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		tree.setup({
			view = {
				width = 42,
				relativenumber = true,
			},
			renderer = {
				icons = {
					glyphs = {
						folder = {
							arrow_closed = "",
							arrow_open = "",
						},
					},
				},
			},
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
			git = {
				ignore = false,
			},
		})

		keymap.set("n", "<leader>ee", "<cmd>NvimTreeFocus<CR>", { desc = "Open file explorer" })
		keymap.set("n", "<leader>ew", "<cmd>NvimTreeClose<CR>", { desc = "Close file explorer" })
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFileToggle<CR>",
			{ desc = "Toggle file explorer on current file" }
		)
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })
	end,
}
