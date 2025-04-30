local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
	vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
end

local tree = require("nvim-tree")

local config = {
	on_attach = my_on_attach,
	hijack_cursor = true,
	sync_root_with_cwd = true,
	respect_buf_cwd = true,
	hijack_directories = {
		enable = false,
	},
	filters = {
		custom = { ".git" },
		exclude = { ".gitignore", ".env" },
	},
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = {},
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true,
		show_on_open_dirs = true,
		debounce_delay = 50,
		severity = {
			min = vim.diagnostic.severity.HINT,
			max = vim.diagnostic.severity.ERROR,
		},
	},
	renderer = {
		highlight_git = "name",
		highlight_diagnostics = "name",
		highlight_opened_files = "name",
		highlight_modified = "name",
		indent_markers = {
			enable = true,
			inline_arrows = true,
			icons = {
				corner = "└",
				edge = "│",
				item = "│",
				bottom = "─",
				none = " ",
			},
		},
		icons = {
			web_devicons = {
				file = {
					enable = true,
					color = true,
				},
				folder = {
					enable = true,
					color = true,
				},
			},
			git_placement = "before",
			modified_placement = "after",
			diagnostics_placement = "signcolumn",
			bookmarks_placement = "signcolumn",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = true,
				modified = true,
				diagnostics = true,
				bookmarks = true,
			},
			glyphs = {
				default = "",
				symlink = "",
				bookmark = "󰆤",
				modified = "●",
				folder = {
-- arrow_open = icons.ui.ArrowOpen,
					-- 					arrow_closed = icons.ui.ArrowClosed,
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "★",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	git = {
		enable = true,
		ignore = false,
		show_on_dirs = true,
		show_on_open_dirs = true,
		timeout = 200,
	},
	view = {
		cursorline = true,
		float = {
			enable = false,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			},
		},
		width = 30,
		side = "left",
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
}

tree.setup(config)
