{ pkgs, ... }: {
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplicationPackages = with pkgs; [
        brave
        discord
      ];
    };
  };
}
