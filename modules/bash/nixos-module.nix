{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ fzf ];
  programs.bash = {
    shellAliases = import ./shell-aliases.nix { inherit pkgs; };
    interactiveShellInit = import ./shell-init.nix { inherit pkgs; };
  };
}
