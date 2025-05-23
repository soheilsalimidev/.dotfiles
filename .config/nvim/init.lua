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
require("plugins.gitsigns")
require("plugins.tele")
require("plugins.treesitter")
require("plugins.lsp")
require("plugins.trouble")
require('plugins.conform')