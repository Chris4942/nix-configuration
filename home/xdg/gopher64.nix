{ pkgs }: {
  gopher64 = {
    exec = "${pkgs.gopher64}/bin/gopher64";
    name = "Gopher64";
    terminal = false;
    type = "Application";
  };
}
