{
  nixpkgs,
  nvf,
  home-manager,
  ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    inherit nvf;
  };

  modules = [
    ./configuration.nix
    ./hardware.nix
    ./immich.nix
    ../../../modules/localization/new-york.nix
    ../../../modules/bash/nixos-module.nix
    ../../../modules/nix-ld.nix
    ../../../modules/nvf/module.nix
    ../../../modules/jellyfin.nix
    nvf.nixosModules.default
    ./next-cloud.nix
    ./cron.nix
    home-manager.nixosModules.default
  ];
}
