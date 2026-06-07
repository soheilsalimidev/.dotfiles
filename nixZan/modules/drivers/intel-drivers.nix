{ lib, pkgs, config, ... }:
with lib;
let cfg = config.drivers.intel;
in {
  options.drivers.intel = {
    enable = mkEnableOption "Enable Intel Graphics Drivers";
  };

  config = mkIf cfg.enable {
    hardware.graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        libvdpau-va-gl
        intel-vaapi-driver
        libva-vdpau-driver
      ];
    };
  };
}
