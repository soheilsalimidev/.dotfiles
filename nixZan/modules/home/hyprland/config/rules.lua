--- WINDOW TAGS ----
hl.window_rule({ match = { class = "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$" }, tag = "+file-manager" })
hl.window_rule({ match = { class = "^(Alacritty|kitty|kitty-dropterm|org.wezfurlong.wezterm)$" }, tag = "+terminal" })
hl.window_rule({ match = { class = "^(Brave-browser(-beta|-dev|-unstable)?|zen-beta)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^([Tt]horium-browser|[Cc]achy-browser)$" }, tag = "+browser" })
hl.window_rule({ match = { class = "^(codium|codium-url-handler|VSCodium)$" }, tag = "+projects" })
hl.window_rule({ match = { class = "^(VSCode|code-url-handler|code)$" }, tag = "+projects" })
hl.window_rule({ match = { class = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop|spotify)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^([Ww]hatsapp-for-linux)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(teams-for-linux)$" }, tag = "+im" })
hl.window_rule({ match = { class = "^(gamescope)$" }, tag = "+games" })
hl.window_rule({ match = { class = "^(steam_app_%d+)$" }, tag = "+games" })
hl.window_rule({ match = { class = "^([Ss]team)$" }, tag = "+gamestore" })
hl.window_rule({ match = { title = "^([Ll]utris)$" }, tag = "+gamestore" })
hl.window_rule({ match = { class = "^(com.heroicgameslauncher.hgl)$" }, tag = "+gamestore" })
hl.window_rule({ match = { class = "^(gnome-disks|wihotspot(-gui)?)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^([Rr]ofi)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(file-roller|org.gnome.FileRoller)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(nm-applet|nm-connection-editor|blueman-manager)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "^(nwg-look|qt5ct|qt6ct|[Yy]ad)$" }, tag = "+settings" })
hl.window_rule({ match = { class = "(xdg-desktop-portal-gtk)" }, tag = "+settings" })
hl.window_rule({ match = { class = "(.blueman-manager-wrapped)" }, tag = "+settings" })
hl.window_rule({ match = { class = "(nwg-displays)" }, tag = "+settings" })

---- WORKSPACE ASSIGNMENTS ----
hl.window_rule({ match = { tag = "browser*" }, workspace = "2 silent", opacity = "0.85 0.90" })
hl.window_rule({ match = { class = "^(spotify)$" }, workspace = "6 silent" })
hl.window_rule({ match = { class = "^(code)$" }, workspace = "3 silent" })

---- FLOATING RULES ----
hl.window_rule({ match = { class = "^([Ww]aypaper)$" }, float = true })
hl.window_rule({ match = { class = "([Tt]hunar)", title = "negative:(.*[Tt]hunar.*)" }, float = true, center = true })
hl.window_rule({ match = { title = "^(Authentication Required)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(mpv|com.github.rafostar.Clapper)$" }, float = true })
hl.window_rule({ match = { class = "(codium|codium-url-handler|VSCodium)", title = "negative:(.*codium.*|.*VSCodium.*)" }, float = true })
hl.window_rule({ match = { class = "^(com.heroicgameslauncher.hgl)$", title = "negative:(Heroic Games Launcher)" }, float = true })
hl.window_rule({ match = { class = "^([Ss]team)$", title = "negative:^([Ss]team)$" }, float = true })
hl.window_rule({ match = { initial_title = "(Add Folder to Workspace)" }, float = true, size = "(monitor_w*0.7) (monitor_h*0.6)" })
hl.window_rule({ match = { initial_title = "(Open Files)" }, float = true, size = "(monitor_w*0.7) (monitor_h*0.6)" })
hl.window_rule({ match = { initial_title = "(wants to save)" }, float = true })
hl.window_rule({ match = { tag = "settings*" }, float = true, size = "(monitor_w*0.7) (monitor_h*0.7)", opacity = "0.8 0.7" })

---- SETTINGS CENTER ----
hl.window_rule({ match = { class = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" }, center = true })

---- FERDIUM ----
hl.window_rule({ match = { class = "^([Ff]erdium)$" }, tag = "+im", center = true, float = true, size = "(monitor_w*0.6) (monitor_h*0.7)" })

---- PICTURE-IN-PICTURE ----
hl.window_rule({
  match = { title = "^(Picture-in-Picture)$" },
  float = true,
  pin = true,
  move = "(monitor_w*0.72) (monitor_h*0.07)",
  opacity = "0.95 0.9",
  keep_aspect_ratio = true,
})

---- IDLE INHIBIT ----
hl.window_rule({ match = { class = "^(.*)$" }, idle_inhibit = "fullscreen" })
hl.window_rule({ match = { fullscreen = true }, idle_inhibit = "fullscreen" })

---- OPACITY ----
hl.window_rule({ match = { tag = "projects*" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { tag = "im*" }, opacity = "0.75 0.82" })
hl.window_rule({ match = { tag = "file-manager*" }, opacity = "0.9 0.8" })
hl.window_rule({ match = { tag = "terminal*" }, opacity = "0.85 0.8" })
hl.window_rule({ match = { class = "^(gedit|org.gnome.TextEditor|mousepad)$" }, opacity = "0.8 0.7" })
hl.window_rule({ match = { class = "^(seahorse)$" }, opacity = "0.9 0.8" })

---- GAMES ----
hl.window_rule({ match = { tag = "games*" }, no_blur = true, fullscreen = true })
