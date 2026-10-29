{ pkgs, ... }: {
  home.file = {
    ".config/monitors.xml" = {
      source = ../default-monitors.xml;
      force = true;
    };
  };

  xdg = {
    enable = true;
    desktopEntries = { } // (import ../../../../home/xdg/gopher64.nix { inherit pkgs; });
  };

  home.stateVersion = "24.11"; # Please read the comment before changing.
}
