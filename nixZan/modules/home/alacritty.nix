{pkgs, ...}: {
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
# dynamic_padding = true

# [window.padding]
# x = 15
# y = 15

[scrolling]
history = 10000
multiplier = 3

# [bell]
# animation = "Linear"
# duration = 0
# command = { program = "paplay", args = [
#   "/usr/share/sounds/freedesktop/stereo/dialog-error.oga",
# ] }

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
# Color scheme for Pamela Rice

# Default colors
[colors.primary]
background = "#1D1F28"
foreground = "#FDFDFD"

# Cursor colors
[colors.cursor]
cursor = "#FF4971"
text = "#1D1F28"

# Normal colors
[colors.normal]
black = "#3D4C5F"
blue = "#8897F4"
cyan = "#79E6F3"
green = "#5ADECD"
magenta = "#C574DD"
red = "#F37F97"
white = "#FDFDFD"
yellow = "#F2A272"

# Bright colors
[colors.bright]
black = "#56687E"
blue = "#556FFF"
cyan = "#3FDCEE"
green = "#18E3C8"
magenta = "#B043D1"
red = "#FF4971"
white = "#BEBEC1"
yellow = "#FF8037"

  '';
}
