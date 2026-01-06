{ host, ... }:
let inherit (import ../../../hosts/${host}/variables.nix) extraMonitorSettings;
in {
  wayland.windowManager.hyprland = {
    settings = {
      windowrule = [
        "tag +file-manager, match:class ^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$"
        "tag +terminal, match:class ^(Alacritty|kitty|kitty-dropterm|org.wezfurlong.wezterm)$"
        "tag +browser, match:class ^(Brave-browser(-beta|-dev|-unstable)?|zen-beta)$"
        "tag +browser, match:class ^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$"
        "tag +browser, match:class ^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$"
        "tag +browser, match:class ^([Tt]horium-browser|[Cc]achy-browser)$"
        "tag +projects, match:class ^(codium|codium-url-handler|VSCodium)$"
        "tag +projects, match:class ^(VSCode|code-url-handler|code)$"
        "tag +im, match:class ^([Dd]iscord|[Ww]ebCord|[Vv]esktop|spotify)$"
        "tag +im, center on, float on, size (monitor_w*0.6) (monitor_h*0.7), match:class ^([Ff]erdium)$"
        "tag +im, match:class ^([Ww]hatsapp-for-linux)$"
        "tag +im, match:class ^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$"
        "tag +im, match:class ^(teams-for-linux)$"
        "tag +games, match:class ^(gamescope)$"
        "tag +games, match:class ^(steam_app_d+)$"
        "tag +gamestore, match:class ^([Ss]team)$"
        "tag +gamestore, match:title ^([Ll]utris)$"
        "tag +gamestore, match:class ^(com.heroicgameslauncher.hgl)$"
        "tag +settings, match:class ^(gnome-disks|wihotspot(-gui)?)$"
        "tag +settings, match:class ^([Rr]ofi)$"
        "tag +settings, match:class ^(file-roller|org.gnome.FileRoller)$"
        "tag +settings, match:class ^(nm-applet|nm-connection-editor|blueman-manager)$"
        "tag +settings, center on, match:class ^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$"
        "tag +settings, match:class ^(nwg-look|qt5ct|qt6ct|[Yy]ad)$"
        "tag +settings, match:class (xdg-desktop-portal-gtk)"
        "tag +settings, match:class (.blueman-manager-wrapped)"
        "tag +settings, match:class (nwg-displays)"
        "move ((monitor_w*0.72)) ((monitor_h*0.07)), float on, opacity 0.95 0.9, pin on, keep_aspect_ratio on, match:title ^(Picture-in-Picture)$"
        "workspace 2 silent, opacity 0.85 0.90, match:tag browser*"
        "workspace 6 silent, match:class ^(spotify)$"
        "workspace 3 silent, match:class ^(code)$"
        "float on, match:class ^([Ww]aypaper)$"
        "center on, float on, match:class ([Tt]hunar), match:title negative:(.*[Tt]hunar.*)"
        "center on, float on, match:title ^(Authentication Required)$"
        "idle_inhibit fullscreen, match:class ^(*)$"
        "idle_inhibit fullscreen, match:title ^(*)$"
        "idle_inhibit fullscreen, match:fullscreen 1"
        "float on, size (monitor_w*0.7) (monitor_h*0.7), opacity 0.8 0.7, match:tag settings*"
        "float on, match:class ^(mpv|com.github.rafostar.Clapper)$"
        "float on, match:class (codium|codium-url-handler|VSCodium), match:title negative:(.*codium.*|.*VSCodium.*)"
        "float on, match:class ^(com.heroicgameslauncher.hgl)$, match:title negative:(Heroic Games Launcher)"
        "float on, match:class ^([Ss]team)$, match:title negative:^([Ss]team)$"
        "float on, size (monitor_w*0.7) (monitor_h*0.6), match:initial_title (Add Folder to Workspace)"
        "float on, size (monitor_w*0.7) (monitor_h*0.6), match:initial_title (Open Files)"
        "float on, match:initial_title (wants to save)"
        "opacity 0.9 0.8, match:tag projects*"
        "opacity 0.75 0.82, match:tag im*"
        "opacity 0.9 0.8, match:tag file-manager*"
        "opacity 0.8 0.7, match:tag terminal*"
        "opacity 0.8 0.7, match:class ^(gedit|org.gnome.TextEditor|mousepad)$"
        "opacity 0.9 0.8, match:class ^(seahorse)$ # gnome-keyring gui"
        "no_blur on, fullscreen on, match:tag games*"
      ];

      env = [
        "NIXOS_OZONE_WL, 1"
        "NIXPKGS_ALLOW_UNFREE, 1"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_SESSION_TYPE, wayland"
        "XDG_SESSION_DESKTOP, Hyprland"
        "GDK_BACKEND, wayland, x11"
        "CLUTTER_BACKEND, wayland"
        "QT_QPA_PLATFORM=wayland;xcb"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
        "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
        "SDL_VIDEODRIVER, x11"
        "MOZ_ENABLE_WAYLAND, 1"
        "AQ_DRM_DEVICES,/dev/dri/card0:/dev/dri/card1"
        "GDK_SCALE,1"
        "QT_SCALE_FACTOR,1"
        "EDITOR,nvim"
      ];
    };

    extraConfig =
      "\n      monitor=,preferred,auto,auto\n      ${extraMonitorSettings}\n    ";
  };
}
