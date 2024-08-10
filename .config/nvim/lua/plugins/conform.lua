local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "prettier" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		liquid = { "prettier" },
		lua = { "stylua" },
		vue = { "prettier" },
		python = { "isort", "black" },
		prisma = { "prismals" , lsp_format = "fallback" },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>lf", function()
	conform.format({
		lsp_fallback = false,
		async = true,
		-- timeout_ms = 4000,
	})
end, { desc = "Format file or range (in visual mode)" })
