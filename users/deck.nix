{ pkgs, ... }:
{
  imports = [
    ../modules/nvf/config.nix
    ../home/zoxide.nix
    ../home/terminal/kitty.nix
    ../home/harper
    ../home/git.nix
    ../modules/bash/home-manager-module.nix
  ];
  home.packages = with pkgs; [
    zoxide
    kitty
    fzf
  ];
  home.username = "deck";
  home.homeDirectory = "/home/deck";
  programs.bash.enable = true;
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
