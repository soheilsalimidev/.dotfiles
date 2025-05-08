{ inputs, pkgs, ... }: {
  home.file = {
    ".wezterm.lua" = {
      source = ./wezterm.lua;
      recursive = true;
    };
  };

  programs.starship = {
    enable = true;
    settings = pkgs.lib.importTOML ../starship/starship.toml;
  };
  programs.wezterm = {
    enable = true;
    # package = inputs.wezterm.packages.${pkgs.system}.default;
  };

}
