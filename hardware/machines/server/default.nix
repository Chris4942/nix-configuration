{
  nixpkgs,
  nvf,
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
    ../../../modules/localization/new-york.nix
    ../../../modules/bash.nix
    ../../../modules/zoxide.nix
    ../../../modules/nix-ld.nix
    ../../../modules/nvf/module.nix
    ../../../modules/jellyfin.nix
    nvf.nixosModules.default
    ./next-cloud.nix
  ];
}
