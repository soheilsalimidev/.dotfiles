
-- Other keymaps
vim.api.nvim_set_keymap("n", "B", "^", { noremap = false })
vim.api.nvim_set_keymap("n", "ss", ":noh<CR>", { noremap = true, desc = "remove search" })

-- Splits
vim.api.nvim_set_keymap("n", "<C-W>,", ":vertical resize -10<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-W>.", ":vertical resize +10<CR>", { noremap = true })

vim.keymap.set("n", "<leader>qq", ":q<CR>", { silent = true, noremap = true, desc = "exit window" })
vim.keymap.set("n", "<leader>nn", ":Noice dismiss<CR>", { noremap = true, desc = "Noice dismiss" })
vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { noremap = true, desc = "NvimTreeToggle" })

-- Visual mode keymaps
--
vim.keymap.set("v", "<leader>p", "pgvy")
vim.keymap.set("v", "<leader>y", '"+y')

-- Move to the end of the line in normal and visual modes
vim.keymap.set({ "n", "v" }, "<Tab>", "$")

-- Buffer navigation
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<A-h>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-l>", "<Cmd>BufferNext<CR>", opts)
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
map("n", "<A-A>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)

-- Toggle comment on the current line
vim.keymap.set("n", "<leader>/", function()
	require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })

local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)

-- Toggle comment in visual mode
vim.keymap.set("x", "<leader>/", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.linewise(vim.fn.visualmode())
end)

-- Toggle block comment in visual mode
vim.keymap.set("x", "<leader>bb", function()
	vim.api.nvim_feedkeys(esc, "nx", false)
	require("Comment.api").toggle.blockwise(vim.fn.visualmode())
end)

-- Move by visual line in normal mode
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")


map("n", "<leader>sa", "<Cmd>SessionSearch<CR>", opts)


