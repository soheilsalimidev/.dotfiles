{ pkgs, host, options, ... }: {
  networking = {
    hostName = "${host}";
    networkmanager = {
      enable = true;
      plugins = with pkgs; [ networkmanager-openvpn ];
    };
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 57621 5179 3000 3001 443 ];
      allowedUDPPorts = [ 57621 5179 3000 3001 443];
      allowedTCPPortRanges = [{
        from = 1714;
        to = 1764;
      }];

      allowedUDPPortRanges = [{
        from = 1714;
        to = 1764;
      }];
    };
  };
  services.resolved = { enable = true; };
  systemd.services.NetworkManager-wait-online.enable = false;
  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
