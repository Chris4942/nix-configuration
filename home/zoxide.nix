{ pkgs, ... }:
{
  home.packages = with pkgs; [ zoxide ];
  programs.zoxide = {
    options = [ "--cmd cd" ];
    enable = true;
  };
}
