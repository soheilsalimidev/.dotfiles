-- require('telescope').load_extension('git_worktree')
-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require("telescope").setup({
	defaults = {
		path_display = { "smart" },
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {

				preview_width = 0.65,
				horizontal = {
					size = {
						width = "95%",
						height = "95%",
					},
				},
			},
		},
		pickers = {
			find_files = {
				theme = "dropdown",
			},
		},
		mappings = {
			i = {
				["<C-u>"] = false,
				["<C-j>"] = require("telescope.actions").move_selection_next,
				["<C-k>"] = require("telescope.actions").move_selection_previous,
				["<C-d>"] = require("telescope.actions").move_selection_previous,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>sb", function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = true,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set("n", "<leader>f", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>st", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>sS", require("telescope.builtin").git_status, { desc = "" })
vim.keymap.set("n", "<Leader>sn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>")

vim.api.nvim_set_keymap("n", "<Leader>sT", ":TodoTelescope<CR>", { noremap = true })
vim.api.nvim_set_keymap(
	"n",
	"<Leader><tab>",
	"<Cmd>lua require('telescope.builtin').commands()<CR>",
	{ noremap = false }
)
