-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("n", "<leader>nn", ":Noice dismiss<CR>", { noremap = true, desc = "Noice dismiss" })
vim.keymap.set("v", "<leader>p", "pgvy")
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>/", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
vim.keymap.set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })
vim.keymap.set("n", "<A-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<A-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set({ "n", "v" }, "<Tab>", "$")
vim.keymap.set("n", "<A-c>", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })
