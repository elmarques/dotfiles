return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				css = { "prettierd" },
				html = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				lua = { "stylua" },
				sh = { "shfmt" },
				zsh = { "shfmt" },
				python = { "black" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
			formatters = {
				shfmt = {
					prepend_args = { "-i", "2" },
				},
			},
		})

		vim.api.nvim_create_user_command("KillPrettierd", function()
			local handle = io.popen("pgrep -f prettierd | xargs kill -9")

			if handle ~= nil then
				handle:close()
				print("Prettierd killed")
			end
		end, {})
	end,
}
