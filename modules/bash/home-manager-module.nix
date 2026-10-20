{ pkgs, ... }:
{
  programs.bash = {
    shellAliases = import ./shell-aliases.nix { inherit pkgs; };
    initExtra = import ./shell-init.nix { inherit pkgs; };
  };
}
