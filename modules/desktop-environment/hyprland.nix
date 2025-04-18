{pkgs, ...}: {
  programs.hyprland.enable = true; # enable Hyprland

  environment.systemPackages = [
    # ... other packages
    pkgs.kitty # required for the default Hyprland config
    pkgs.rose-pine-hyprcursor
    pkgs.hyprlock
    pkgs.hypridle
  ];

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
