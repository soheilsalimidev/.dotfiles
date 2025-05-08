local wezterm = require("wezterm")
local act = wezterm.action
local tabline = wezterm.plugin.require("https://github.com/michaelbrusegard/tabline.wez")
local domains = wezterm.plugin.require("https://github.com/DavidRR-F/quick_domains.wezterm")
local workspace_switcher = wezterm.plugin.require("https://github.com/MLFlexer/smart_workspace_switcher.wezterm")

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- config.font = wezterm.font_with_fallback({
--   "JetBrainsMono",
--   "Kawkab Mono",
-- })
config.bidi_enabled = true
config.bidi_direction = 'AutoLeftToRight'
config.font_size = 13.7
config.line_height = 1.2
config.adjust_window_size_when_changing_font_size = true
config.use_dead_keys = false
config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.scrollback_lines = 10000
config.default_workspace = "home"
config.front_end = "WebGpu"
config.warn_about_missing_glyphs = false
config.color_scheme = "Tokyo Night"
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.term = "xterm-256color"
config.max_fps = 144
config.animation_fps = 30

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.8,
}

config.leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
  { key = 'l', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(1) },
  { key = 'h', mods = 'ALT|SHIFT', action = act.ActivateTabRelative(-1) },
  {
    key = 'h',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Left',
  },
  {
    key = 'l',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Right',
  },
  {
    key = 'k',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Up',
  },
  {
    key = 'j',
    mods = 'CTRL',
    action = act.ActivatePaneDirection 'Down',
  },
  { key = "a", mods = "LEADER|CTRL",  action = wezterm.action { SendString = "\x01" } },
  { key = "-", mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "|", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "s", mods = "LEADER",       action = wezterm.action { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = "v", mods = "LEADER",       action = wezterm.action { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "o", mods = "LEADER",       action = "TogglePaneZoomState" },
  { key = "z", mods = "LEADER",       action = "TogglePaneZoomState" },
  { key = "c", mods = "LEADER",       action = wezterm.action { SpawnTab = "CurrentPaneDomain" } },
  { key = "h", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Left" } },
  { key = "j", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Down" } },
  { key = "k", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Up" } },
  { key = "l", mods = "LEADER",       action = wezterm.action { ActivatePaneDirection = "Right" } },
  { key = "H", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Left", 5 } } },
  { key = "J", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Down", 5 } } },
  { key = "K", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Up", 5 } } },
  { key = "L", mods = "LEADER|SHIFT", action = wezterm.action { AdjustPaneSize = { "Right", 5 } } },
  { key = "q", mods = "LEADER",       action = wezterm.action { CloseCurrentPane = { confirm = true } } },
}
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1),
  })
end

-- Tab Bar
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = false
tabline.setup({
  options = {
    icons_enabled = true,
    theme = 'Tokyo Night',
    tabs_enabled = true,
    section_separators = '',
    component_separators = '',
    tab_separators = '',
  },
  sections = {
    tabline_a = { 'mode' },
    tabline_b = { 'workspace' },
    tabline_c = { ' ' },
    tab_active = {
      'index',
      { 'parent', padding = 0 },
      '/',
      { 'cwd',    padding = { left = 0, right = 1 } },
      { 'zoomed', padding = 0 },
    },
    tab_inactive = { 'index', { 'process', padding = { left = 3, right = 3 } } },
    tabline_x = { 'ram', 'cpu' },
    tabline_y = {},
    tabline_z = { 'domain' },
  },
  extensions = {},
})

workspace_switcher.apply_to_config(config)
domains.apply_to_config(config, {
  keys = {
    attach = {
      key  = 'S',
      mods = 'SUPER',
    },
  }
})

local ssh_domains = {}

for host, _ in pairs(wezterm.enumerate_ssh_hosts()) do
  table.insert(ssh_domains, {
    name = host,
    remote_address = host,
    multiplexing = "None",
    assume_shell = 'Posix',
  })
end
config.ssh_domains = ssh_domains

return config
