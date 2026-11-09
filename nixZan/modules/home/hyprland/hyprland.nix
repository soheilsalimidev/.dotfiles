{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
in
{

  home.packages = with pkgs; [

    awww
    grim
    slurp
    wl-clipboard
    swappy
    ydotool
    hyprpolkitagent
    hyprland-qtutils

    foot
    wlogout
    # wl-ocr
    # gnome-calculator
    # gnome-control-center
    # gpu-screen-recorder-gtk
    playerctl
    # brightnessctl
    # hyprlock
    vicinae
  ];

  home.file = {
    "Pictures/Wallpapers" = {
      source = ../../../wallpapers;
      recursive = true;
    };
    ".face.icon".source = ./face.jpg;
    ".config/face.jpg".source = ./face.jpg;
  };

  xdg.configFile =
    let
      lua = [
        ./config/animations.lua
        ./config/binds.lua
        ./config/hyprland.lua
        ./config/rules.lua
        ./config/settings.lua
        ./config/smartgaps.lua
      ];
    in
    builtins.listToAttrs (
      map (e: {
        name = "hypr/${lib.baseNameOf e}";
        value.source = e;
      }) lua
    );

  wayland.windowManager.hyprland = {
    configType = "lua";
    enable = true;
    package = pkgs.hyprland;
    # systemd = {
    #   enable = true;
    #   enableXdgAutostart = true;
    #   variables = [ "--all" ];
    # };
    xwayland.enable = true;
  };
}
