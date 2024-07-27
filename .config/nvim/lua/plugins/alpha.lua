local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
-- Set header
dashboard.section.header.val = {
	"                               _                    _                      _   ",
	" (_)                          | |                  | |                    | |  ",
	"  _  _ __     __ _   ___    __| | __      __  ___  | |_  _ __  _   _  ___ | |_ ",
	[[| || '_ \   / _` | / _ \  / _` | \ \ /\ / / / _ \ | __|| '__|| | | |/ __|| __|]],
	[[| || | | | | (_| || (_) || (_| |  \ V  V / |  __/ | |_ | |   | |_| |\__ \| |_ ]],
	[[|_||_| |_|  \__, | \___/  \__,_|   \_/\_/   \___|  \__||_|    \__,_||___/ \__|]],
	[[             __/ |                                                            ]],
	[[            |___/                                                             ]],
}

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("<leader>f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
	dashboard.button("<leader>qs", "  > currct session"),
	dashboard.button("<leader>ql", "  > last session"),
	dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
	dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
