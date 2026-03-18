{ pkgs, ... }:
{
  imports = [ ../modules/nvf/config.nix ];
  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
