{ host, ... }:

let inherit (import ../../hosts/${host}/variables.nix) waybarChoice;
in {
  nixpkgs.config.allowUnfree = true;
  imports = [
    ./alacritty.nix
    ./tmux.nix
    ./bat.nix
    ./btop.nix
    ./emoji.nix
    ./fastfetch
    ./gh.nix
    ./git.nix
    ./gtk.nix
    ./htop.nix
    ./hyprland
    ./rofi
    ./qt.nix
    ./scripts
    ./stylix.nix
    ./swappy.nix
    ./swaync.nix
    ./virtmanager.nix
    waybarChoice
    ./wlogout
    ./xdg.nix
    ./yazi
    ./zoxide.nix
    ./zsh
    ./direnv.nix
    ./spotify.nix
    ./kdeconnect.nix
    ./wezterm/wezterm.nix
  ];
}
