{ pkgs, ... }: {
  xdg = {
    enable = true;
    terminal-exec = {
      enable = true;
      package = pkgs.kitty;
      settings = {
        default = [ "kitty.desktop" ];
      };
    };
    desktopEntries = {
      neovim = {
        exec = "vim %F";
        mimeType = [
          "text/plain"
          "text/json"
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
