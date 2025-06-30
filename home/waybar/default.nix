{
  config,
  lib,
  pkgs,
  ...
}:
{
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
        # "width" =  1280, // Waybar width
        "spacing" = 5; # Gaps between modules (4px)
        # Choose the order of the modules
        # "margin-left" = 25;
        # "margin-right" = 25;
        "margin-bottom" = -11;
        #"margin-top" = 5;
        modules-left = [ "hyprland/workspaces" ];
        modules-right = [
          "bluetooth"
          "pulseaudio/slider"
          "cpu"
          "clock#day"
          "clock#date"
          "clock#time"
        ];
        modules-center = [
          "hyprland/window"
          "hyprland/submap"
        ];
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
          icon = true;
          icon-size = 12;
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
        "clock#day" = {
          format = "{:%A}";
          tooltip-format = "Vecka: {:%V}";
        };
        "clock#time" = {
          timezone = "America/New_York";
          tooltip-format = "<big>{:%Z %z}</big>\n<small>Eastern Time</small>";
        };
        "clock#date" = {
          format = "{:%d-%m-%Y}";
          tooltip-format = "<big>{calendar}</big>";
        };
      }
    ];
  };
}
