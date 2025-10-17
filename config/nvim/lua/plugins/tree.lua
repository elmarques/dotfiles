return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local tree = require("nvim-tree")
		local tree_api = require("nvim-tree.api").tree
		local keymap = vim.keymap
		local devicons = require("nvim-web-devicons")

		devicons.setup({
			override = {
				astro = {
					icon = "",
					color = "#EF8547",
					name = "astro",
				},
			},
		})

		tree.setup({
			disable_netrw = true,
			hijack_cursor = true,
			sync_root_with_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				preserve_window_proportions = true,
			},
			renderer = {
				root_folder_label = false,
				highlight_git = true,
			},
		})

		vim.api.nvim_create_autocmd("VimEnter", {
			callback = function()
				if vim.fn.argc() == 0 then
					tree_api.open()
				end
			end,
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
