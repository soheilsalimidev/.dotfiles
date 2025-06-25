local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "dprint" },
		typescript = { "dprint" },
		javascriptreact = { "dprint" },
		typescriptreact = { "dprint" },
		svelte = { "dprint" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "dprint" },
		yaml = { "dprint" },
		toml = { lsp_format = true },
		markdown = { "prettierd" },
		graphql = { "dprint" },
		liquid = { "prettier" },
		lua = { lsp_format = true },
		vue = { "dprint" , "rustywind" },
		python = { "isort", "black" },
		prisma = { "prismals", lsp_format = "fallback" },
		rust = { "rustfmt", lsp_format = "fallback" },
		nix = { "nixfmt", lsp_format = "fallback" },
		sh = { "beautysh", lsp_format = "fallback" },
		sql = { "sql_formatter", prepend_args = { "-c", '{"keywordCase": "language"}' } },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>lf", function()
	conform.format({
		lsp_fallback = false,
		async = true,
		-- timeout_ms = 4000,
	})
end, { desc = "Format file or range (in visual mode)" })
