require("plugins.lsp_config.lua_ls")
-- require("plugins.lsp_config.tsserver_ls")
require("plugins.lsp_config.vtsls")
require("plugins.lsp_config.vue_ls")

vim.opt.completeopt = { "menuone", "fuzzy", "noinsert", "preview" }
vim.o.omnifunc = "v:lua.vim.lsp.omnifunc"
vim.lsp.enable({
	-- "tsserver_ls",
	"vtsls",
	"vue_ls",
	"css-variables_ls",
	"css_ls",
	"lua_ls",
	"hyprls",
	"yamlls",
	"rust_analyzer",
	"docker_ls",
	"nil_ls",
	"prismals",
	"eslint",
	"taplo",
	"nil_ls",
	"markdown_oxide"
})
-- Diagnostic keymaps
vim.keymap.set("n", "gl", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- enable built-in auto-completion and set up lsp features on attach
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local buffer = args.buf

		if not client then
			return
		end

		if client:supports_method("workspace/symbol") then
			vim.keymap.set("n", "grs", vim.lsp.buf.workspace_symbol, {
				buffer = buffer,
				desc = "LSP: Select LSP workspace symbol"
			})
		end

		vim.api.nvim_buf_set_keymap(buffer, "i", "<Tab>", [[v:lua.tab_complete()]],
			{ noremap = true, expr = true, silent = true })

		-- LSP Keybindings
		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {
			buffer = buffer,
			desc = "LSP: [R]e[n]ame"
		})
		vim.keymap.set("n", "<leader>la", require('tiny-code-action').code_action, {
			buffer = buffer,
			desc = "LSP: [C]ode [A]ction"
		})
		vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {
			buffer = buffer,
			desc = "LSP: [G]oto [D]efinition"
		})
		vim.keymap.set("n", "gr", require('telescope.builtin').lsp_references, {
			buffer = buffer,
			desc = "LSP: [G]oto [R]eferences"
		})
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {
			buffer = buffer,
			desc = "LSP: [G]oto [I]mplementation"
		})
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, {
			buffer = buffer,
			desc = "LSP: Type [D]efinition"
		})
		vim.keymap.set("n", "<leader>ds", require('telescope.builtin').lsp_document_symbols, {
			buffer = buffer,
			desc = "LSP: [D]ocument [S]ymbols"
		})
		vim.keymap.set("n", "<leader>ws", require('telescope.builtin').lsp_dynamic_workspace_symbols,
			{
				buffer = buffer,
				desc = "LSP: [W]orkspace [S]ymbols"
			})
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {
			buffer = buffer,
			desc = "LSP: Hover Documentation"
		})
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, {
			buffer = buffer,
			desc = "LSP: Signature Documentation"
		})
		vim.keymap.set("n", "<leader>ld", vim.lsp.buf.declaration, {
			buffer = buffer,
			desc = "LSP: [G]oto [D]eclaration"
		})
		vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, {
			buffer = buffer,
			desc = "LSP: [W]orkspace [A]dd Folder"
		})
		vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, {
			buffer = buffer,
			desc = "LSP: [W]orkspace [R]emove Folder"
		})
		vim.keymap.set("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, { buffer = buffer, desc = "LSP: [W]orkspace [L]ist Folders" })

		vim.keymap.set("n", "<leader>k", function()
			if vim.diagnostic.config().virtual_lines == true then
				vim.diagnostic.config({ virtual_lines = { current_line = true } })
			else
				vim.diagnostic.config({ virtual_lines = true })
			end
		end, { buffer = buffer, desc = "Toggle showing all diagnostics or just current line" })
	end,
})

vim.diagnostic.config({
	virtual_text = { spacing = 4, prefix = "●" },
	virtual_lines = { current_line = true },
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

require("mason").setup()
require("fidget").setup({})
