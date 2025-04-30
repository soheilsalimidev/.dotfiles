{ pkgs, host, options, ... }: {
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall = {
      enable = true;
      allowedTCPPorts = [ 57621 ];
      allowedUDPPorts = [ 57621 ];
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

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
