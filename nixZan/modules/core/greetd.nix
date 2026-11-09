{ pkgs, username, ... }: {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        user = "arthur";
        command = "${pkgs.tuigreet}/bin/tuigreet --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red -r --time --cmd Hyprland"; # start Hyprland with a TUI login manager
      };
    };
  };
}
