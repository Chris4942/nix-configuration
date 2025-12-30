{ pkgs, ... }:
{
  imports = [ ../modules/nvf/module.nix ];
  home.username = "deck";
  home.homeDirectory = "/home/deck";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
