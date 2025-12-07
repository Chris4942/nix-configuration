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
    ./hardware.nix
    ./configuration.nix
    ../../../modules/fonts.nix
    ../../../modules/localization/new-york.nix
    ../../../modules/bash.nix
    ../../../modules/nix-ld.nix
    ../../../modules/audio.nix
    ../../../modules/nvf/module.nix
    ../../../modules/desktop-environment/hyprland.nix
    nvf.nixosModules.default
    home-manager.nixosModules.default
  ];
}
