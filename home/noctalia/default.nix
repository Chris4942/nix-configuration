{ lib, ... }:
{
  imports = [ ./config.nix ];

  options.cwest.noctalia = {
    background = lib.mkOption {
      type = lib.types.path;
      default = ../../data/backgrounds/wallhaven-7pxxmo_2560x1440.png;
      description = "Background image path";
    };
  };
}
