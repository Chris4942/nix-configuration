{ ... }:
{
  imports = [
    ../../../home/terminal/kitty.nix
    ../../../home/desktop-environments/hyprland.nix
    ../../../home/waybar/default.nix
    ../../../home/quickshell/module.nix
    ../../../home/zoxide.nix
  ];
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
