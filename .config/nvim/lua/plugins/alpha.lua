local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
-- Set header
dashboard.section.header.val = {
	[[    ____                  ______              __        _       __               ______                           __ ]],
	[[   /  _/   ____          / ____/  ____   ____/ /       | |     / /  ___         /_  __/   _____  __  __   _____  / /_]],
	[[   / /    / __ \        / / __   / __ \ / __  /        | | /| / /  / _ \         / /     / ___/ / / / /  / ___/ / __/]],
	[[  / /    / / / /       / /_/ /  / /_/ // /_/ /         | |/ |/ /  /  __/        / /     / /    / /_/ /  (__  ) / /_  ]],
	[[/___/   /_/ /_/        \____/   \____/ \__,_/          |__/|__/   \___/        /_/     /_/     \__,_/  /____/  \__/  ]],
}

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("<leader>f", "  > Find file"),
	dashboard.button("<leader>qs", "  > currct session"),
	dashboard.button("<leader>ql", "  > last session", ":Telescope persisted"),
	dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
	dashboard.button("q", "󰈆  > Quit NVIM", ":qa<CR>"),
}

alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
