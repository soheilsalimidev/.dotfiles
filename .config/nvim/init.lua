-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("keymaps")
require("plugins.lazy")
require("plugins.misc")
require("plugins.lualine")
require("options")

require("misc")
require("plugins.alpha")
require("plugins.tree")
require("plugins.dap")
require("plugins.gitsigns")
require("plugins.tele")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.trouble")
require("plugins.zenmode")
require("plugins.neogit")
-- require('plugins.codesnap')
require("plugins.harpoon")

-- vim: ts=8 sts=2 sw=2 et
