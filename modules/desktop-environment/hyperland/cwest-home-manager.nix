{ lib, pkgs, ... }:
{
  enable = true;
  settings = lib.mkOptionDefault {
  };
  extraConfig = ''
    $mod, N, submap, launch

    submap = launch
    bind = b, exec, ${pkgs.brave}/bin/brave
  '';
}
