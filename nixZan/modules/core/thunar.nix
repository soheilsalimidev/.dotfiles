{ host, pkgs, ... }:
let inherit (import ../../hosts/${host}/variables.nix) thunarEnable;
in {
  programs = { thunar = { enable = thunarEnable; }; };
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
    thunar-archive-plugin
    thunar-volman
  ];
}
