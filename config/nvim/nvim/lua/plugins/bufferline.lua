return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local bufferline = require("bufferline")
		local theme = require("catppuccin.groups.integrations.bufferline")

		bufferline.setup({
			options = {
				mode = "tabs",
				always_show_bufferline = false,
				offsets = {
					{
						filetype = "NvimTree",
						text = false,
					},
				},
				tab_size = 20,
			},
			highlights = theme.get(),
		})
	end,
}
