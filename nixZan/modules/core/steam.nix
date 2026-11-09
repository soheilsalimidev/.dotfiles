{ pkgs, ... }: {
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      gamescopeSession.enable = true;
      extraCompatPackages = [ pkgs.proton-ge-bin ];
    };
    gamescope = {
      enable = true;
      capSysNice = true;
      args = [
        "--rt"
        "--expose-wayland"
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    gamemode
    wineWow64Packages.stable
    wineWow64Packages.staging
    wineWow64Packages.waylandFull
    winetricks
    gnome-disk-utility
  ];
}
