{ host, pkgs, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) printEnable;
in
{
  services = {
    printing = {
      enable = printEnable;
      drivers = [ pkgs.epson-escpr ];
    };
    avahi = {
      enable = printEnable;
      nssmdns4 = true;
      openFirewall = true;

      settings.publish = {
        # old publish.enable -> inverted
        disable-publishing = !printEnable;

        # old publish.userServices -> inverted
        disable-user-service-publishing = false;

        # old publish.userServices implies publish-addresses = true
        publish-addresses = true;
      };
    };
    ipp-usb.enable = printEnable;
  };
}
