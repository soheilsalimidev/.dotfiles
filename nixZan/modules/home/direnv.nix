{ config, ... }: {
  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true; # see note on other shells below
      nix-direnv.enable = true;
    };

    zsh.enable = true;
    zsh.dotDir = "${config.xdg.configHome}/zsh";
  };
}
