# In your home-manager configuration
{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    python3
  ];

  # Create the monitor manager script
  # home.file.".config/hypr/monitor_manager.py" = {
  #   source = ./monitor_manager.py;
  #   executable = true;
  # };
  #
  # # Create cache directory
  # home.file.".config/hypr/monitor_cache/.gitkeep".text = "";
}
