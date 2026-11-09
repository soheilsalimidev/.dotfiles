---- ENVIRONMENT VARS ----
hl.env("NIXOS_OZONE_WL", "1")
hl.env("NIXPKGS_ALLOW_UNFREE", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland, x11")
hl.env("CLUTTER_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("SDL_VIDEODRIVER", "x11")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("AQ_DRM_DEVICES", "/dev/dri/card0:/dev/dri/card1")
hl.env("GDK_SCALE", "1")
hl.env("QT_SCALE_FACTOR", "1")
hl.env("EDITOR", "nvim")

---- AUTOSTART ----
hl.on("hyprland.start", function()
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("dbus-update-activation-environment --all --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("killall -q awww; sleep .5 && awww-daemon &")
  hl.exec_cmd("killall -q waybar; sleep .5 && waybar")
  hl.exec_cmd("killall -q swaync; sleep .5 && swaync")
  hl.exec_cmd("nm-applet --indicator")
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("pypr &")
  hl.exec_cmd("sleep 1 && wallsetter")
  hl.exec_cmd("wezterm")
  -- hl.exec_cmd("spotify")
end)

---- GENERAL SETTINGS ----
hl.config({
  general = {
    layout = "scrolling",
    gaps_in = 6,
    gaps_out = 8,
    border_size = 2,
    resize_on_border = true,
    col = {
      active_border = "rgb(base08) rgb(base0C) 45deg", -- replace with actual colors
      inactive_border = "rgb(base01)",
    },
  },
  scrolling = {
    direction = "down",
    column_width = 1.0,
  },
  input = {
    kb_layout = "us", -- replace with your keyboardLayout variable
    kb_options = "grp:win_space_toggle",
    numlock_by_default = true,
    repeat_delay = 300,
    follow_mouse = 1,
    float_switch_override_focus = 0,
    sensitivity = 0,
    touchpad = {
      natural_scroll = true,
      disable_while_typing = true,
      scroll_factor = 0.8,
    },
  },
  gestures = {
    workspace_swipe = true,
    workspace_swipe_fingers = 3,
    workspace_swipe_distance = 500,
    workspace_swipe_invert = true,
    workspace_swipe_min_speed_to_force = 30,
    workspace_swipe_cancel_ratio = 0.5,
    workspace_swipe_create_new = true,
    workspace_swipe_forever = true,
  },
  misc = {
    layers_hog_keyboard_focus = true,
    initial_workspace_tracking = 0,
    mouse_move_enables_dpms = true,
    key_press_enables_dpms = false,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    enable_swallow = false,
    vfr = true,
    vrr = 2,
  },
  dwindle = {
    pseudotile = true,
    preserve_split = true,
  },
  decoration = {
    rounding = 10,
    blur = {
      enabled = true,
      size = 5,
      passes = 3,
      ignore_opacity = false,
      new_optimizations = true,
    },
    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(1a1a1aee)",
    },
  },
  cursor = {
    sync_gsettings_theme = true,
    no_hardware_cursors = 2,
    enable_hyprcursor = false,
    warp_on_change_workspace = 2,
    no_warps = true,
  },
  master = {
    new_status = "master",
    new_on_top = 1,
    mfact = 0.5,
  },
  debug = {
    disable_logs = true,
    suppress_errors = true,
  },
  
})

