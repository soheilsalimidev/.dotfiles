{
  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "Soheil Salimi";
  gitEmail = "soheilsalimidev@gmail.com";

  # Hyprland Settings
  extraMonitorSettings = "";

  # Waybar Settings
  clock24h = false;

  # Program Options
  browser = "zen-beta"; # Set Default Browser (google-chrome-stable for google-chrome)
  terminal = "alacritty"; # Set Default System Terminal
  keyboardLayout = "us,ir";
  consoleKeyMap = "us";

  # For Nvidia Prime support
  intelID = "PCI:1:0:0";
  nvidiaID = "PCI:0:2:0";

  # Enable NFS
  enableNFS = false;

  # Enable Printing Support
  printEnable = true;

  # Set Stylix Image
  stylixImage = ../../wallpapers/AnimeGirlNightSky.jpg;

  # Set Waybar
  # Includes alternates such as waybar-simple.nix & waybar-ddubs.nix
  waybarChoice = ../../modules/home/waybar/waybar-colorfull.nix;

  # Set Animation style
  # Available options are:
  # animations-def.nix  (default)
  # animations-end4.nix (end-4 project)
  # animations-dynamic.nix (ml4w project)
  animChoice = ../../modules/home/hyprland/animations-dynamic.nix;

  # Enable Thunar GUI File Manager
  thunarEnable = true;
}
