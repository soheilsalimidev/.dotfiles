{pkgs, ...}: {
  home.packages = with pkgs; [pyprland];

  home.file.".config/pypr/config.toml".text = ''
    [pyprland]
    plugins = [
      "scratchpads",
    ]
  '';
}
