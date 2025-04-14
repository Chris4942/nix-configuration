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
        modules-right = ["pulseaudio/slider" "cpu" "clock"];
        modules-center = [];
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "hyprctl dispatch workspace {id}";
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
      }
    ];
  };
}
