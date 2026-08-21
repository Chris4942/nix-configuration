{ pkgs, ... }: {
  xdg = {
    enable = true;
    mimeApps.defaultApplicationPackages = with pkgs; [ brave ];
  };
}
