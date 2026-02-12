{ lib, ... }:
{
  imports = [ ./config.nix ];
  options.cwest.hyprland.extraBind = lib.mkOption {
    type = lib.types.listOf lib.types.str;
    default = [ ];
    description = "Extra bind just for this machine";
  };
  options.cwest.hyprland.extraExtraConfig = lib.mkOption {
    type = lib.types.str;
    default = "";
    description = "Extra extraConfig for just this machine";
  };
}
