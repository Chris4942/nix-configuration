{ pkgs, ... }: {
  xdg = {
    enable = true;
    desktopEntries = {
      neovim = {
        exec = "vim %F";
        mimeType = [
          "text/plain"
          "text/json"
          "text/xml"
          "application/x-desktop"
        ];
        name = "Neovim";
        terminal = true;
        type = "Application";
      };
      lnav = {
        exec = "${pkgs.lnav}/bin/lnav %F";
        mimeType = [ "text/x-log" ];
        name = "lnav";
        terminal = true;
        type = "Application";
      };
      superfile = {
        exec = "${pkgs.superfile}/bin/superfile";
        mimeType = [ "inode/directory" ];
        name = "superfile";
        terminal = true;
        type = "Application";
      };
    };
    mimeApps = {
      enable = true;
      defaultApplicationPackages = with pkgs; [
        brave
        discord
        kitty
      ];
    };
  };
}
