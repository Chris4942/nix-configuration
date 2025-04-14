{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = builtins.readFile ./style.css;
    settings = [
      {
        "layer" = "top"; # Waybar at top layer
        "position" = "top"; # Waybar position (top|bottom|left|right)
        "height" = 50; # Waybar height (to be removed for auto height)
        # "width" =  1280, // Waybar width
        "spacing" = 5; # Gaps between modules (4px)
        # Choose the order of the modules
        # "margin-left" = 25;
        # "margin-right" = 25;
        "margin-bottom" = -11;
        #"margin-top" = 5;
        "modules-left" = ["wlr/workspaces"];
        "modules-right" = ["temperature" "network" "battery" "custom/ss" "custom/cycle_wall" "custom/expand" "cpu" "clock"];
        "modules-center" = ["custom/dynamic_pill"];
        # Modules configuration

        # custom modules ////////////////
        "custom/dynamic_pill" = {
          "return-type" = "json";
          "exec" = "~/.config/hypr/scripts/tools/start_dyn";
          "escape" = true;
        };
        "custom/ss" = {
          "format" = "{}";
          "exec" = "~/.config/hypr/scripts/tools/expand ss-icon";
          "on-click" = "~/.config/hypr/scripts/screenshot_full";
        };
        "custom/cycle_wall" = {
          "format" = "{}";
          "exec" = "~/.config/hypr/scripts/tools/expand wall";
          # "interval" =  1;
          "on-click" = "~/.config/hypr/scripts/tools/expand cycle";
        };
        "custom/expand" = {
          "on-click" = "~/.config/hypr/scripts/expand_toolbar";
          "format" = "{}";
          "exec" = "~/.config/hypr/scripts/tools/expand arrow-icon";
        };
        # "custom/waybar-mpris" =  {
        #     "return-type" =  "json";
        #     "exec" =  "echo '   '";
        #     "on-click" =  "waybar-mpris --send toggle";
        #     // This option will switch between players on right click.
        #         "on-click-right" =  "waybar-mpris --send player-next";
        #     // The options below will switch the selected player on scroll
        #         // "on-scroll-up" =  "waybar-mpris --send player-next";
        #         // "on-scroll-down" =  "waybar-mpris --send player-prev";
        #     // The options below will go to next/previous track on scroll
        #         // "on-scroll-up" =  "waybar-mpris --send next";
        #         // "on-scroll-down" =  "waybar-mpris --send prev";
        #     "escape" =  true
        # };
        #////////////////////////////////
        "keyboard-state" = {
          "numlock" = true;
          "capslock" = true;
          "format" = "{name} {icon}";
          "format-icons" = {
            "locked" = "";
            "unlocked" = "";
          };
        };
        "wlr/workspaces" = {
          "format" = "{icon}";
          "format-active" = " {icon} ";
          "on-click" = "activate";
          # "format-icons" = {
          #     "10" = "10"
          # }
        };
        "sway/mode" = {
          "format" = "<span style=\"italic\">{}</span>";
        };
        "mpd" = {
          "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ";
          "format-disconnected" = "Disconnected ";
          "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
          "unknown-tag" = "N/A";
          "interval" = 2;
          "consume-icons" = {
            "on" = " ";
          };
          "random-icons" = {
            "off" = "<span color=\"#f53c3c\"></span> ";
            "on" = " ";
          };
          "repeat-icons" = {
            "on" = " ";
          };
          "single-icons" = {
            "on" = "1 ";
          };
          "state-icons" = {
            "paused" = "";
            "playing" = "";
          };
          "tooltip-format" = "MPD (connected)";
          "tooltip-format-disconnected" = "MPD (disconnected)";
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "tray" = {
          # "icon-size" =  21;
          "spacing" = 10;
        };
        "clock" = {
          # "timezone" =  "America/New_York";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "interval" = 60;
          "format" = "{:%I:%M}";
          "max-length" = 25;
        };
        "cpu" = {
          "interval" = 1;
          "format" = "{icon0} {icon1} {icon2} {icon3}";
          "format-icons" = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
        };
        "memory" = {
          "format" = "{}% ";
        };
        "temperature" = {
          # "thermal-zone" =  2;
          # "hwmon-path" =  "/sys/class/hwmon/hwmon2/temp1_input";
          "critical-threshold" = 80;
          "format-critical" = "{temperatureC}°C";
          "format" = "";
        };
        "backlight" = {
          # "device" =  "acpi_video1";
          "format" = "{percent}% {icon}";
          "format-icons" = ["" "" "" "" "" "" "" "" ""];
        };
        "battery" = {
          "states" = {
            "warning" = 50;
            "critical" = 20;
          };
          "format" = "{icon}";
          "format-charging" = "";
          "format-plugged" = "";
          # "format-good" =  "", // An empty format will hide the module
          # "format-full" =  "";
          "format-icons" = ["" "" "" "" ""];
        };
        "battery#bat2" = {
          "bat" = "BAT2";
        };
        "network" = {
          # "interface" =  "wlp2*", // (Optional) To force the use of this interface
          "format-wifi" = "";
          "format-ethernet" = "";
          "tooltip-format" = "via {gwaddr} {ifname}";
          "format-linked" = "";
          "format-disconnected" = "wifi";
          "format-alt" = "   ";
        };
        "pulseaudio" = {
          # "scroll-step" =  1, // %, can be a float
          "format" = "{format_source}";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = " {format_source}";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["" "" ""];
          };
          "on-click" = "pavucontrol";
        };
        "custom/media" = {
          "format" = "{icon} {}";
          "return-type" = "json";
          "max-length" = 40;
          "format-icons" = {
            "spotify" = "";
            "default" = "🎜";
          };
          "escape" = true;
          "exec" = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
          # "exec" =  "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" // Filter player based on name
        };
      }
    ];
  };
}
