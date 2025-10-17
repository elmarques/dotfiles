return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		local ibl = require("ibl")
		local config = {
			enabled = false,
			indent = { char = "▏" },
		}

		vim.opt.listchars = {
			space = "⋅",
			eol = "↴",
			tab = "▏ ",
		}
		vim.opt.list = false
		ibl.setup(config)

		function ToggleInvisibles()
			if config.enabled then
				config.enabled = false
			else
				config.enabled = true
			end

			vim.opt.list = config.enabled
			ibl.update(config)
		end

		vim.api.nvim_create_user_command("ToggleInvisibles", ToggleInvisibles, {})
		vim.keymap.set("n", "<leader>it", ":ToggleInvisibles<CR>", { desc = "Toggle invisibles" })
	end,
}
