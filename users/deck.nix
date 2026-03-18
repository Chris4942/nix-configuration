{ pkgs, ... }:
{
  imports = [
    ../modules/nvf/config.nix
    ../home/zoxide.nix
    ../home/terminal/kitty.nix
  ];
  home.packages = with pkgs; [
    zoxide
    kitty
  ];
  home.username = "deck";
  home.homeDirectory = "/home/deck";
  programs.bash.enable = true;
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
