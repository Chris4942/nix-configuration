{...}: {
  programs.bash = {
	  shellAliases = {
      g = "git";
      n = "nvim .";
      ns = "nix-shell";
    };
  };
}
