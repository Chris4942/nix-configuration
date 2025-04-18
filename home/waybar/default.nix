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
        modules-left = ["hyprland/workspaces"];
        modules-right = ["bluetooth" "pulseaudio/slider" "cpu" "clock"];
        modules-center = ["hyprland/window" "hyprland/submap"];
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "hyprctl dispatch workspace {id}";
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
        "hyprland/window" = {
          "format" = "{class}:{title}";
          "separate-outputs" = true;
        };
        "hyprland/submap" = {
          format = "{}";
          tooltip = false;
        };
        "bluetooth" = {
          # "controller"= "controller1", # specify the alias of the controller if there are more than 1 on the system
          format = " {status}";
          format-disabled = ""; # an empty format will hide the module
          format-connected = " {num_connections} connected";
          tooltip-format = "{controller_alias}\t{controller_address}";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
        };
      }
    ];
  };
}
