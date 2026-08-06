{ host, pkgs, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) thunarEnable;
in
{
  # programs = {
  #   xfconf.enable = true;
  #   thunar = {
  #     enable = thunarEnable;
  #     plugins = with pkgs; [
  #       thunar-archive-plugin
  #       thunar-volman
  #     ];
  #   };
  # };
}
