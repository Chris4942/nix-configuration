{ pkgs, ... }: {
  g = "git";
  n = "vim .";
  ns = "nix-shell";
  nd = "nix develop";
  pbc = "wl-copy";
  pbp = "wl-paste";
  ls = "${pkgs.eza}/bin/eza";
}
