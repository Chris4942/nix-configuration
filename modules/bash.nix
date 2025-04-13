{ pkgs, ... }:
{
  programs.bash = {
    shellAliases = {
      g = "git";
      n = "vim .";
      ns = "nix-shell";
    };
    interactiveShellInit = ''
      . ${pkgs.git}/share/git/contrib/completion/git-completion.bash
      __git_complete g __git_main

      export EDITOR=${pkgs.neovim}/bin/nvim;
    '';
  };
}
