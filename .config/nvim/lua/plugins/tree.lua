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
	vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Open"))
end

local tree = require("nvim-tree")
-- local icons = require("core.plugin_config.icons")

local config = {
	on_attach = my_on_attach,
	hijack_cursor = true,
	hijack_directories = {
		enable = false,
	},
	filters = {
		custom = { ".git" },
		exclude = { ".gitignore", ".env" },
	},
	update_cwd = true,
	renderer = {
		special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
		add_trailing = false,
		group_empty = false,
		highlight_git = "name",
		highlight_opened_files = "none",
		root_folder_modifier = ":t",
		indent_markers = {
			enable = true,
			icons = {
				corner = "└ ",
				edge = "│ ",
				none = "  ",
			},
		},
		icons = {
			webdev_colors = true,
			git_placement = "before",
			padding = " ",
			symlink_arrow = " ➛ ",
			show = {
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
			},
			glyphs = {
				default = "",
				symlink = "",
				folder = {
					-- arrow_open = icons.ui.ArrowOpen,
					-- arrow_closed = icons.ui.ArrowClosed,
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
					symlink_open = "",
				},
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					untracked = "U",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		-- icons = {
		--   hint = icons.diagnostics.Hint,
		--   info = icons.diagnostics.Information,
		--   warning = icons.diagnostics.Warning,
		--   error = icons.diagnostics.Error,
		-- },
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 2000,
		show_on_dirs = true,
		show_on_open_dirs = true,
	},
	view = {
		width = 30,
		-- hide_root_folder = false,
		side = "left",
		-- auto_resize = true,
		number = false,
		relativenumber = false,
	},
}

tree.setup(config)
