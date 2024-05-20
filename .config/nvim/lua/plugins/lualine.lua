return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")
		local status_section = {
			lazy_status.updates,
			cond = lazy_status.has_updates,
			color = { fg = "#ff9e64" },
		}

		lualine.setup({
			options = {
				component_separators = "",
			},
			sections = {
				lualine_x = { status_section, "encoding", "fileformat", "filetype" },
			},
		})
	end,
}
