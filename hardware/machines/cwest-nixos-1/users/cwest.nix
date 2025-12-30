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

  cwest.hyprland.extraBind = [ ];
  cwest.hyprland.extraExtraConfig = ''
    monitor = HDMI-A-1, disable
  '';
}
