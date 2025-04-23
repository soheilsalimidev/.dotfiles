{ pkgs, lib, host, config, ... }:
let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../../../hosts/${host}/variables.nix) clock24h;
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
          background: transparent;
          color: #cdd6f4;
          margin: 4px 0;
          padding: 0;
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
          padding: 0 12px;
          margin: 0 2px;
          color: #6c7086;
          font-size: 14px;
          border-radius: 8px;
          transition: all 0.3s ease;
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
      /* System Components       */
      /* ======================= */
      #clock {
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 8px;
          color: #e5e0cf;
          background: rgba(137, 180, 250, 0.2);
          font-weight: 500;
          transition: all 0.3s ease;
      }

      #clock:hover {
          background: rgba(137, 180, 250, 0.2);
          box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
      }

      #cpu {
          color: #74c7ec;
          background: rgba(116, 199, 236, 0.2);
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 8px;
      }

      #memory {
          color: #89dceb;
          background: rgba(137, 220, 235, 0.2);
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 8px;
      }

      #battery {
          color: #a6e3a1;
          background: rgba(166, 227, 161, 0.2);
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 8px;
      }

      #temperature {
          color: #f5c2e7;
          background: rgba(245, 194, 231, 0.2);
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 8px;
          transition: all 0.3s ease;
      }

      #temperature.critical {
          color: #f38ba8;
          background: rgba(243, 139, 168, 0.2);
      }

      /* ======================= */
      /* Audio Controls          */
      /* ======================= */
      #pulseaudio {
          color: #fab387;
          background: rgba(250, 179, 135, 0.2);
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 8px;
      }

      #pulseaudio.microphone {
          color: #94e2d5;
          background: rgba(148, 226, 213, 0.2);
      }


      /* #pulseaudio.source.muted {
          color: #f38ba8;
          background: rgba(243, 139, 168, 0.1);
      } */

      #pulseaudio.microphone.source-muted {
          color: #f38ba8;
          background: rgba(243, 139, 168, 0.2);
      }

      /* ======================= */
      /* Hardware Controls       */
      /* ======================= */
      #backlight {
          color: #cba6f7;
          background: rgba(203, 166, 247, 0.2);
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 8px;
      }

      /* ======================= */
      /* System Indicators       */
      /* ======================= */
      #tray {
          background: rgba(180, 190, 254, 0.2);
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 8px;
      }

      #custom-exit {
          color: rgb(236, 0, 63);
          background: rgba(255, 161, 173 , 0.2);
          margin: 0 4px;
          padding: 0 12px;
          border-radius: 8px;
      }

      #custom-notification {
          color: rgb(21, 93, 252);
          background: rgba(142, 197, 255, 0.2);
          margin: 0 4px;
          padding: 0 12px;
          border-radius: 8px;
          transition: all 0.3s ease;
      }

      #custom-arch {
          color: #e5e0cf;
          background: rgba(137, 180, 250, 0.2);
          padding: 0 14px;
          margin: 0 4px;
          border-radius: 8px;
          transition: all 0.3s ease;
      }

      #custom-arch:hover,
      #pulseaudio:hover,
      #backlight:hover,
      #custom-exit:hover,
      #custom-update:hover,
      #pulseaudio.microphone:hover {
          opacity: 0.8;
      }

      #hyprland-workspaces button:hover,
      #workspaces button:hover {
          transition: all 0.3s ease;
          opacity: 0.8;
      }

      /* Media Player */
      /* #custom-media {
        color: #b4befe;
        padding: 0 12px;
        margin: 0 4px;
        border-radius: 8px;
        background: rgba(180, 190, 254, 0.1);
        transition: all 0.3s ease;
        min-width: 100px;
        font-style: italic;
      }

      #custom-media:hover {
        background: rgba(180, 190, 254, 0.2);
      }

      #custom-media.Playing {
        color: #a6e3a1;
        background: rgba(166, 227, 161, 0.1);
      }

      #custom-media.Paused {
        color: #f9e2af;
        background: rgba(249, 226, 175, 0.1);
      } */


      /* Media Player */
      #mpris {
          color: #b4befe;
          padding: 0 12px;
          margin: 0 4px;
          border-radius: 8px;
          background: rgba(180, 190, 254, 0.1);
          transition: all 0.3s ease;
          min-width: 100px;
      }

      #mpris:hover {
          background: rgba(180, 190, 254, 0.2);

      }

      #mpris.playing {
          color: #a6e3a1;
          background: rgba(166, 227, 161, 0.1);

      }

      #mpris.paused {
          color: #f9e2af;
          background: rgba(249, 226, 175, 0.1);
      }

      #mpris.stopped {
          color: #6c7086;
          background: rgba(249, 226, 175, 0.1);
      }
    ''];
  };
}
