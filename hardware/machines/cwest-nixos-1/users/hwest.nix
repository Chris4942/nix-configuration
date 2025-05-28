{...}: {
  home.file = {
    ".config/monitors.xml" = {
      source = ../default-monitors.xml;
      force = true;
    };
  };

  home.stateVersion = "24.11"; # Please read the comment before changing.
}
