{ pkgs, ... }: {
  xdg = {
    enable = true;
    mime.enable = true;
    mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = [ "zen-beta.desktop" ];
        "x-scheme-handler/http" = [ "zen-beta.desktop" ];
        "x-scheme-handler/https" = [ "zen-beta.desktop" ];
        "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
        "text/html" = [ "zen-beta.desktop" ];
        "application/x-extension-htm" = [ "zen-beta.desktop" ];
        "application/x-extension-html" = [ "zen-beta.desktop" ];
        "application/x-extension-shtml" = [ "zen-beta.desktop" ];
        "application/xhtml+xml" = [ "zen-beta.desktop" ];
        "application/x-extension-xhtml" = [ "zen-beta.desktop" ];
        "application/x-extension-xht" = [ "zen-beta.desktop" ];

      };
      defaultApplications = {
        "application/pdf" = [ "org.gnome.Evince.desktop" ];
        "x-scheme-handler/http" = [ "zen-beta.desktop" ];
        "x-scheme-handler/https" = [ "zen-beta.desktop" ];
        "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
        "text/html" = [ "zen-beta.desktop" ];
        "application/x-extension-htm" = [ "zen-beta.desktop" ];
        "application/x-extension-html" = [ "zen-beta.desktop" ];
        "application/x-extension-shtml" = [ "zen-beta.desktop" ];
        "application/xhtml+xml" = [ "zen-beta.desktop" ];
        "application/x-extension-xhtml" = [ "zen-beta.desktop" ];
        "application/x-extension-xht" = [ "zen-beta.desktop" ];
      };
    };
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
      configPackages = [ pkgs.hyprland ];
    };
  };
}
