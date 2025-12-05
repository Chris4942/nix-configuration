{ ... }:
{
  imports = [
    ../../../../users/cwest.nix
  ];

  home.file = {
    ".config/monitors.xml" = {
      source = ../default-monitors.xml;
      force = true;
    };
  };
}
