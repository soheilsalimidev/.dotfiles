-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
	-- NOTE: Remember that lua is a real programming language, and as such it is possible
	-- to define small helper and utility functions so you don't have to repeat yourself
	-- many times.
	--
	-- In this case, we create a function that lets us more easily define mappings specific
	-- for LSP related items. It sets the mode, buffer and description for us each time.
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end

		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
	end

	if vim.lsp.inlay_hint then
		nmap("<leader>L", function()
			if vim.lsp.inlay_hint.is_enabled() then
				vim.lsp.inlay_hint.enable(false, { bufnr })
			else
				vim.lsp.inlay_hint.enable(true, { bufnr })
			end
		end, "Toggle Inlay Hints")
	end

	nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
	nmap("<leader>la", function()
		require("tiny-code-action").code_action()
	end, "[C]ode [A]ction")
	nmap("<leader>gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
	nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
	nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
	nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
	nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
	nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

	-- See `:help K` for why this keymap
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

	-- Lesser used LSP functionality
	nmap("<leader>ld", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
	nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
	nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
	nmap("<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, "[W]orkspace [L]ist Folders")

end

-- Setup mason so it can manage external tooling
require("mason").setup()

-- Enable the following language servers
-- Feel free to add/remove any LSPs that you want here. They will automatically be installed
local servers = { "rust_analyzer", "pyright", "ts_ls", "volar", "lua_ls" }

-- Ensure the servers above are installed
require("mason-lspconfig").setup({
	ensure_installed = servers,
})

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
	require("lspconfig")[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Turn on lsp status information
require("fidget").setup({})

-- Example custom configuration for lua
--
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT)
				version = "LuaJIT",
				-- Setup your lua path
				path = runtime_path,
			},
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = { enable = false },
		},
	},
})

require("lspconfig").tailwindcss.setup({
	on_attach = function(_, bufnr)
		require("tailwindcss-colors").buf_attach(bufnr)
		on_attach(bufnr)
	end,
	capabilities = capabilities,
	filetypes = { "css", "vue", "html" },
})

require("lspconfig").ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayVariableTypeHints = true,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
				includeInlayParameterNameHintsWhenArgumentMatchesName = true,
				includeInlayVariableTypeHints = true,

				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHintsWhenTypeMatchesName = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
	init_options = {
		plugins = {
			{
				name = "@vue/typescript-plugin",
				location = "/home/arthur/.local/share/nvim/mason/packages/vue-language-server/node_modules/@vue/language-server",
				languages = { "vue" },
			},
		},
	},
	filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" },
})

require("lspconfig").rust_analyzer.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
			add_return_type = {
				enable = true,
			},
			inlayHints = {
				enable = true,
				showParameterNames = true,
				parameterHintsPrefix = "<- ",
				otherHintsPrefix = "=> ",
			},
		},
	},
})

require("lspconfig").yamlls.setup({
	filetypes = { "yml", "ymal" },
})

-- require("lspconfig").eslint.setup({
-- 	filetypes = { "vue", "typescript", "javascript" },
-- })

-- require('lspconfig').java.setup {
--   filetypes = { 'java' },
-- }

require("lspconfig").sqlls.setup({
	filetypes = { "sql" },
})

require("lspconfig").prismals.setup({
	filetypes = { "prisma" },
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "sh",
	callback = function()
		vim.lsp.start({
			name = "bash-language-server",
			cmd = { "bash-language-server", "start" },
		})
	end,
})
