{host, ...}: let
  inherit (import ../../hosts/${host}/variables.nix) keyboardLayout;
in {
  services.xserver = {
    enable = false;
    xkb = {
      layout = "${keyboardLayout}";
      variant = "";
       options = "grp:win_space_toggle";
    };
  };
}
