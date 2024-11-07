local harpoon = require("harpoon")
local harpoonEx = require("harpoonEx")

harpoon:setup({})
harpoon:extend(harpoonEx.extend())

vim.keymap.set("n", "<leader>m", function()
	harpoon:list():add()
end)

vim.keymap.set("n", "<leader>sh", function()
	require("telescope").extensions.harpoonEx.harpoonEx({
		-- Optional: modify mappings, default mappings:
		attach_mappings = function(_, map)
			local actions = require("telescope").extensions.harpoonEx.actions
			map({ "i", "n" }, "<leader>d", actions.delete_mark)
			map({ "i", "n" }, "<leader>k", actions.move_mark_up)
			map({ "i", "n" }, "<leader>j", actions.move_mark_down)
			return true
		end,
	})
	return true
end, { desc = "Open harpoon window" })

