{ ... }:
let
  # Require pressing all the buttons so I don't do this on accident
  allModifiers = "$mod SHIFT CONTROL_L ALT_L";
in
{
  imports = [
    ../../../../users/cwest.nix
  ];

  home.file = {
    ".config/monitors.xml" = {
      source = ../default-monitors.xml;
      force = true;
    };
  };

  cwest.hyprland.extraBind = [
    "${allModifiers}, M, submap, monitors"
  ];
  cwest.hyprland.extraExtraConfig =
    let
      reset = "hyprctl dispatch submap reset;";
    in
    ''
      monitor = HDMI-A-1, disable

      submap = monitors
        # To the TV; why Y? Because it mirrors T (for TV), but it can be pressed with my right hand
        bind = ${allModifiers}, Y, exec, ${reset} hyprctl keyword monitor "HDMI-A-1, preferred, auto, 1" && hyprctl keyword monitor "DP-3, disabled"
        # To the office
        bind = ${allModifiers}, O, exec, ${reset} hyprctl keyword monitor "DP-3, preferred, auto, 1" && hyprctl keyword monitor "HDMI-A-1, disabled"
        bind = , catchall, submap, reset
      submap = reset
    '';
}
