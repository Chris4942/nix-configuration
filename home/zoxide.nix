{ pkgs, ... }:
{
  # Make sure to also set
  # programs.bash.enable = true;
  home.packages = with pkgs; [ zoxide ];
  programs.zoxide = {
    options = [ "--cmd cd" ];
    enable = true;
  };
}
