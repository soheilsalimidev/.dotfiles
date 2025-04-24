{ pkgs, lib, host, config, ... }:
let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../../../hosts/${host}/variables.nix) clock24h;
  colors = import ../../../lib/colors.nix { nixpkgs-lib = lib; };
  
  # Define alpha values for better contrast
  alpha = "0.3";
  alphaHover = "0.35";
  
  # Function to create rgba string using the new color module
  mkRGBA = hex: let
    rgb = colors.hexToRGB (lib.removePrefix "#" hex);
  in "rgba(${toString (builtins.elemAt rgb 0)}, ${toString (builtins.elemAt rgb 1)}, ${toString (builtins.elemAt rgb 2)}, ${alpha})";

  mkRGBAHover = hex: let
    rgb = colors.hexToRGB (lib.removePrefix "#" hex);
  in "rgba(${toString (builtins.elemAt rgb 0)}, ${toString (builtins.elemAt rgb 1)}, ${toString (builtins.elemAt rgb 2)}, ${alphaHover})";

  # Define common styles for components
  commonStyle = ''
    padding: 2px 8px;
    margin: 4px 2px;
    border-radius: 8px;
    transition: ${betterTransition};
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
    border: 1px solid rgba(255, 255, 255, 0.05);
  '';

in with lib; {
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [{
      layer = "top";
      position = "top";
      modules-center = [ "clock" ];
      modules-left =
        [ "custom/startmenu" "hyprland/workspaces" "mpris" "idle_inhibitor" ];
      modules-right = [
        "tray"
        "custom/notification"
        "pulseaudio"
        "backlight"
        "battery"
        "temperature"
        "custom/power"
        "custom/exit"
      ];
      "mpris" = {
        "format" = "{player_icon} {title} - {artist}";
        "format-paused" = "{player_icon} {title} - {artist}";
        "format-icons" = {
          Playing = "󰏤";
          Paused = "󰐊";
          Stopped = "󰐊";
        };
        "player-icons" = {
          default = "";
          spotify = "";
          firefox = "";
          chrome = "";
          vlc = "󰕼";
        };
        "max-length" = 30;
        "return-type" = "json";
        "interval" = 1;
        "on-click" = "playerctl play-pause";
        "on-click-right" = "playerctl next";
        "on-click-middle" = "playerctl previous";
        "on-scroll-up" = "playerctl position 5+";
        "on-scroll-down" = "playerctl position 5-";
        "tooltip" = false;
      };

      "hyprland/workspaces" = {
        format = "{name}";
        format-icons = {
          default = " ";
          active = " ";
          urgent = " ";
        };
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      "clock" = {
        format = if clock24h == true then " {:L%H:%M}" else " {:L%I:%M %p}";
        tooltip = true;
        tooltip-format = ''
          <big>{:%A, %d.%B %Y }</big>
          <tt><small>{calendar}</small></tt>'';
      };
      "memory" = {
        interval = 5;
        format = " {}%";
        tooltip = true;
      };
      "cpu" = {
        interval = 5;
        format = " {usage:2}%";
        tooltip = true;
      };
      "disk" = {
        format = " {free}";
        tooltip = true;
      };
      "network" = {
        format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
        format-ethernet = " {bandwidthDownOctets}";
        format-wifi = "{icon} {signalStrength}%";
        format-disconnected = "󰤮";
        tooltip = false;
      };
      "tray" = { spacing = 12; };
      "pulseaudio" = {
        "format" = "{icon} {volume}%";
        "format-muted" = "󰝟 Muted";
        "format-icons" = { "default" = [ "󰕿" "󰖀" "󰕾" ]; };
        "on-click-right" = "pavucontrol";
        "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
        "on-scroll-down" =
          "bash -c 'current=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n 1 | awk \"{print \\$5}\"); if [[ \${current%\\%} -lt 100 ]]; then pactl set-sink-volume @DEFAULT_SINK@ +1%; fi'";
        "on-scroll-up" = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
        "tooltip" = false;
        "scroll-step" = 5;
      };
      "custom/exit" = {
        tooltip = false;
        format = "";
        on-click = "sleep 0.1 && wlogout";
      };
      "custom/startmenu" = {
        tooltip = false;
        format = "";
        # exec = "rofi -show drun";
        on-click = "sleep 0.1 && rofi-launcher";
      };
      "custom/hyprbindings" = {
        tooltip = false;
        format = "󱕴";
        on-click = "sleep 0.1 && list-keybinds";
      };
      "idle_inhibitor" = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
        tooltip = "true";
      };
      "custom/notification" = {
        tooltip = false;
        format = "{icon} {}";
        format-icons = {
          notification = "<span foreground='red'><sup></sup></span>";
          none = "";
          dnd-notification = "<span foreground='red'><sup></sup></span>";
          dnd-none = "";
          inhibited-notification =
            "<span foreground='red'><sup></sup></span>";
          inhibited-none = "";
          dnd-inhibited-notification =
            "<span foreground='red'><sup></sup></span>";
          dnd-inhibited-none = "";
        };
        return-type = "json";
        exec-if = "which swaync-client";
        exec = "swaync-client -swb";
        on-click = "sleep 0.1 && task-waybar";
        escape = true;
      };
      "battery" = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "{icon} {capacity}%";
        format-charging = "󰂄 {capacity}%";
        format-plugged = "󱘖 {capacity}%";
        format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        on-click = "";
        tooltip = false;
      };
      "temperature" = {
        interval = 2;
        hwmon-path = "/sys/devices/platform/coretemp.0/hwmon/hwmon4/temp1_input"; # You might need to adjust this path
        critical-threshold = 80;
        format = "{icon} {temperatureC}°C";
        format-icons = ["" "" "" "" ""];
        format-critical = "{icon} {temperatureC}°C";
        tooltip = false;
      };
    }];
    style = concatStrings [''
      * {
          border: 0;
          font-family: "JetBrainsMono Nerd Font Mono";
          font-size: 16px;
          min-height: 24px;
          box-shadow: none;
      }

      window#waybar {
          background: linear-gradient(rgba(30, 30, 46, 0.4), rgba(30, 30, 46, 0.6));
          color: #cdd6f4;
          margin: 4px 0;
          padding: 0 8px;
          border-radius: 12px;
          border: 1px solid rgba(255, 255, 255, 0.1);
      }

      /* ======================= */
      /* Workspace Management    */
      /* ======================= */
      #workspaces {
          margin: 0;
          padding: 0;
      }

      #workspaces button {
          color: #6c7086;
          padding: 0 8px;
          margin: 0 4px;
          border-radius: 8px;
          transition: all 0.3s ease;
      }

      #workspaces button.active {
          color: #e5e0cf;
          background: rgba(137, 180, 250, 0.2);
      }

      #hyprland-workspaces {
          margin: 0 8px;
          padding: 0 8px;
          background: transparent;
      }

      #hyprland-workspaces button {
          ${commonStyle}
          padding: 0 12px;
          font-weight: 500;
      }

      #hyprland-workspaces button.active {
          color: #e5e0cf;
          background: rgba(137, 180, 250, 0.15);
          font-weight: 600;
      }

      #hyprland-workspaces button.urgent {
          color: #f38ba8;
          animation: urgent-pulse 1s ease infinite;
      }

      @keyframes urgent-pulse {
          0% {
              opacity: 0.5;
          }

          100% {
              opacity: 1;
          }

          50% {
              opacity: 0.5;
          }
      }

      #hyprland-workspaces button:hover {
          background: rgba(137, 180, 250, 0.25);
      }

      /* ======================= */
      /* Component Base Styling  */
      /* ======================= */
      #clock, #cpu, #memory, #battery, #temperature,
      #pulseaudio, #backlight, #tray, #custom-exit,
      #custom-notification, #mpris {
          ${commonStyle}
          background: linear-gradient(45deg, rgba(0, 0, 0, 0.2), rgba(0, 0, 0, 0.1));
      }

      /* Component hover effects */
      #clock:hover, #cpu:hover, #memory:hover,
      #battery:hover, #temperature:hover,
      #pulseaudio:hover, #backlight:hover,
      #custom-exit:hover, #custom-notification:hover {
          border: 1px solid rgba(255, 255, 255, 0.15);
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
          background: linear-gradient(45deg, rgba(203, 166, 247, 0.15), rgba(203, 166, 247, 0.05));
      }

      /* ======================= */
      /* System Components       */
      /* ======================= */
      #clock {
          color: #${config.lib.stylix.colors.base0D};
          background: ${mkRGBA config.lib.stylix.colors.base0D};
      }
      #clock:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base0D};
      }

      #cpu {
          color: #${config.lib.stylix.colors.base0C};
          background: ${mkRGBA config.lib.stylix.colors.base0C};
      }
      #cpu:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base0C};
      }

      #memory {
          color: #${config.lib.stylix.colors.base0D};
          background: ${mkRGBA config.lib.stylix.colors.base0D};
      }
      #memory:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base0D};
      }

      #battery {
          color: #${config.lib.stylix.colors.base0B};
          background: ${mkRGBA config.lib.stylix.colors.base0B};
      }
      #battery:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base0B};
      }

      #temperature {
          color: #${config.lib.stylix.colors.base0E};
          background: ${mkRGBA config.lib.stylix.colors.base0E};
      }
      #temperature:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base0E};
      }

      #temperature.critical {
          color: #${config.lib.stylix.colors.base08};
          background: ${mkRGBA config.lib.stylix.colors.base08};
      }
      #temperature.critical:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base08};
      }

      #pulseaudio {
          color: #${config.lib.stylix.colors.base09};
          background: ${mkRGBA config.lib.stylix.colors.base09};
      }
      #pulseaudio:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base09};
      }

      #backlight {
          color: #${config.lib.stylix.colors.base0E};
          background: ${mkRGBA config.lib.stylix.colors.base0E};
      }
      #backlight:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base0E};
      }

      /* ======================= */
      /* System Indicators       */
      /* ======================= */
      #tray {
          background: ${mkRGBA config.lib.stylix.colors.base07};
          padding: 2px 6px;
      }

      #custom-exit {
          color: #${config.lib.stylix.colors.base08};
          background: ${mkRGBA config.lib.stylix.colors.base08};
          border: 1px solid rgba(243, 139, 168, 0.2);
      }
      #custom-exit:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base08};
      }

      #custom-notification {
          color: #${config.lib.stylix.colors.base0D};
          background: ${mkRGBA config.lib.stylix.colors.base0D};
          border: 1px solid rgba(137, 180, 250, 0.2);
      }
      #custom-notification:hover {
          background: ${mkRGBAHover config.lib.stylix.colors.base0D};
      }

      #mpris {
          color: #${config.lib.stylix.colors.base07};
          background: ${mkRGBA config.lib.stylix.colors.base07};
      }

      #mpris.playing {
          color: #${config.lib.stylix.colors.base0B};
          background: ${mkRGBA config.lib.stylix.colors.base0B};
      }

      #mpris.paused {
          color: #${config.lib.stylix.colors.base0A};
          background: ${mkRGBA config.lib.stylix.colors.base0A};
      }

      #mpris.stopped {
          color: #${config.lib.stylix.colors.base04};
          background: ${mkRGBA config.lib.stylix.colors.base04};
      }
    ''];
  };
}
