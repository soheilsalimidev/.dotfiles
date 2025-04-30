{ pkgs, username, ... }: {
  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        user = username;
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --theme border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red --remember --time --cmd Hyprland"; # start Hyprland with a TUI login manager
      };
    };
  };
}
