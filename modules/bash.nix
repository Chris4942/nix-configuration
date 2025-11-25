{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ fzf ];
  programs.bash = {
    shellAliases = {
      g = "git";
      n = "vim .";
      ns = "nix-shell";
      nd = "nix develop";
      pbc = "wl-copy";
      pbp = "wl-paste";
    };
    interactiveShellInit = ''
      . ${pkgs.git}/share/git/contrib/completion/git-completion.bash
      __git_complete g __git_main

      export EDITOR=${pkgs.neovim}/bin/nvim;
      export TERM=xterm
      source ${pkgs.fzf}/share/fzf/key-bindings.bash
      source ${pkgs.fzf}/share/fzf/completion.bash
    '';
  };
}
