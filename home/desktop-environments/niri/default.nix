{ lib, ... }: {
  imports = [ ./module.nix ];
  options.cwest.niri.extraFiles = lib.mkOption {
    type = lib.types.listOf lib.types.path;
    default = [ ];
    description = [ "A list of extra kdl files to include in configuration" ];
  };
}
