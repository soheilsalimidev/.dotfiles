vim.api.nvim_set_keymap("n", "B", "^", { noremap = false })
vim.api.nvim_set_keymap("n", "ss", ":noh<CR>", { noremap = true, desc = "remove search" })
-- --
-- -- splits
-- --
vim.api.nvim_set_keymap("n", "<C-W>,", ":vertical resize -10<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-W>.", ":vertical resize +10<CR>", { noremap = true })
vim.keymap.set("n", "<leader>qq", ":q<CR>", { silent = true, noremap = true, desc = "exit window" })

vim.api.nvim_set_keymap("n", "<leader>nn", ":Noice dismiss<CR>", { noremap = true ,desc = "Noice dismiss" })

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>",{ noremap = true ,desc = "NvimTreeToggle" })

vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>")
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateDown<CR>")
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateUp<CR>")
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateRight<CR>")

vim.keymap.set("v", "<leader>p", "pgvy")
vim.keymap.set("v", "<leader>y", '"+y')

vim.keymap.set({ "n", "v" }, "<Tab>", "$")

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Move to previous/next
map("n", "<A-h>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-l>", "<Cmd>BufferNext<CR>", opts)
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
map("n", "<A-A>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)

vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

vim.keymap.set("x", "<leader>/", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end)

-- Toggle selection (blockwise)
vim.keymap.set("x", "<leader>bb", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.blockwise(vim.fn.visualmode())
end)
