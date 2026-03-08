{ ... }:
{
  imports = [
    ../../../../home/zoxide.nix
    ../../../../home/git.nix
  ];
  programs.bash.enable = true;
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
