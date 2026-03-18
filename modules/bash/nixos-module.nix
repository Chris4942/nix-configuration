{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ fzf ];
  programs.bash = {
    shellAliases = import ./shell-aliases.nix;
    interactiveShellInit = import ./shell-init.nix { inherit pkgs; };
  };
}
