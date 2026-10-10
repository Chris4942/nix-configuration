{
  pkgs,
  lib,
  config,
  ...
}:
let
  extraFiles = config.cwest.niri.extraFiles ++ [ ./cursor.kdl ];
in
{
  imports = [
    ../../noctalia
  ];
  home = {
    # All packages that I use in the config, I'm putting here. They may already be included somewhere else, but I don't wwant this to be imported without these
    packages = with pkgs; [
      rofi
      kitty
      swaylock
      playerctl
      kdePackages.breeze
    ];
  };
  home.file = {
    ".config/niri/config.kdl".text = ''
      include "base.kdl"
    ''
    + (lib.strings.join "\n" (map (f: "include \"${f}\"") extraFiles));
    ".config/niri/base.kdl".source = ./config.kdl;
  };
}
