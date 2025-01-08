{ ... }:
{
  programs.bash = {
    shellAliases = {
      g = "git";
      n = "vim .";
      ns = "nix-shell";
    };
  };
}
