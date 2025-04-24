{ pkgs, ... }: {
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
  };
  home.file."./.config/alacritty/alacritty.toml".text = ''
    [cursor]
    blink_interval = 550
    unfocused_hollow = false
    thickness = 0.15

    [cursor.style]
    blinking = "On"
    shape = "Block"

    [selection]
    save_to_clipboard = true

    [window]
    decorations = "none"
    dynamic_title = true
    opacity = 1

    [window.padding]
    x = 15
    y = 15

    [scrolling]
    history = 10000
    multiplier = 3

    [env]
    TERM = "xterm-256color"

    [general]

    live_config_reload = true
    import = [
      "~/.config/alacritty/rice-colors.toml",
      "~/.config/alacritty/fonts.toml",
    ]
  '';
  home.file."./.config/alacritty/fonts.toml".text = ''
    [font]
    size = 13.2

    builtin_box_drawing = true

    normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
    bold = { family = "JetBrainsMono Nerd Font", style = "Bold" }
    italic = { family = "JetBrainsMono Nerd Font", style = "Italic" }
    bold_italic = { family = "JetBrainsMono Nerd Font", style = "Bold Italic" }

    [terminal]

    [terminal.shell]
    program = "tmux"
  '';

  home.file."./.config/alacritty/rice-colors.toml".text = ''
    [colors.primary]
    background = "#1e1e2e"
    foreground = "#cdd6f4"
    dim_foreground = "#7f849c"
    bright_foreground = "#cdd6f4"

    [colors.cursor]
    text = "#1e1e2e"
    cursor = "#f5e0dc"

    [colors.vi_mode_cursor]
    text = "#1e1e2e"
    cursor = "#b4befe"

    [colors.search.matches]
    foreground = "#1e1e2e"
    background = "#a6adc8"

    [colors.search.focused_match]
    foreground = "#1e1e2e"
    background = "#a6e3a1"

    [colors.footer_bar]
    foreground = "#1e1e2e"
    background = "#a6adc8"

    [colors.hints.start]
    foreground = "#1e1e2e"
    background = "#f9e2af"

    [colors.hints.end]
    foreground = "#1e1e2e"
    background = "#a6adc8"

    [colors.selection]
    text = "#1e1e2e"
    background = "#f5e0dc"

    [colors.normal]
    black = "#45475a"
    red = "#f38ba8"
    green = "#a6e3a1"
    yellow = "#f9e2af"
    blue = "#89b4fa"
    magenta = "#f5c2e7"
    cyan = "#94e2d5"
    white = "#bac2de"

    [colors.bright]
    black = "#585b70"
    red = "#f38ba8"
    green = "#a6e3a1"
    yellow = "#f9e2af"
    blue = "#89b4fa"
    magenta = "#f5c2e7"
    cyan = "#94e2d5"
    white = "#a6adc8"

    [[colors.indexed_colors]]
    index = 16
    color = "#fab387"

    [[colors.indexed_colors]]
    index = 17
    color = "#f5e0dc"
  '';
}
