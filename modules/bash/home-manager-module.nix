{ pkgs, ... }:
{
  programs.bash = {
    shellAliases = import ./shell-aliases.nix;
    initExtra = import ./shell-init.nix { inherit pkgs; };
  };
}
