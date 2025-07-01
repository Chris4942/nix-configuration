{ pkgs, ... }:
{
  programs.hyprland.enable = true; # enable Hyprland

  environment.systemPackages = [
    # ... other packages
    pkgs.kitty # required for the default Hyprland config
    pkgs.rose-pine-hyprcursor
    pkgs.hyprlock
    pkgs.hypridle
    pkgs.grim # screenshot functionality
    pkgs.slurp # screenshot functionality
    pkgs.wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    pkgs.mako # notification system developed by swaywm maintainer
    pkgs.rofi
  ];

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
