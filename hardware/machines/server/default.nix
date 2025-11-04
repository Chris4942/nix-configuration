{
  nixpkgs,
  home-manager,
  nvf,
  ...
}:
nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {
    inherit home-manager nvf;
  };

  modules = [
    ./configuration.nix
    ./hardware.nix
    ../../../modules/localization/new-york.nix
    ../../../modules/bash.nix
    ../../../modules/nix-ld.nix
    ../../../modules/nvf/module.nix
    nvf.nixosModules.default
    home-manager.nixosModules.default
  ];
}
