{ pkgs }:
''
  . ${pkgs.git}/share/git/contrib/completion/git-completion.bash
  __git_complete g __git_main

  export EDITOR=${pkgs.neovim}/bin/nvim;
  export TERM=xterm
  source ${pkgs.fzf}/share/fzf/key-bindings.bash
  source ${pkgs.fzf}/share/fzf/completion.bash
''
