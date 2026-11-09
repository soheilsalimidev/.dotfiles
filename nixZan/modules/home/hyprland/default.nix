{host, ...}: let
  inherit (import ../../../hosts/${host}/variables.nix) animChoice;
in {
  imports = [
    ./hypridle.nix
    ./hyprland.nix
    ./hyprlock.nix
    ./pyprland.nix
  ];
}
