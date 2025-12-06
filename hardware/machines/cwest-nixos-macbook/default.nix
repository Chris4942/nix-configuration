{
  nixpkgs,
  home-manager,
  nvf,
  nixos-hardware,
  ...
}:
nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit home-manager nvf;
  };
  modules = [
    ./configuration.nix
    ../../../modules/fonts.nix
    ../../../modules/localization/new-york.nix
    ../../../modules/bash.nix
    ../../../modules/nix-ld.nix
    ../../../modules/xinput.nix
    ../../../modules/steam.nix
    ../../../modules/audio.nix
    ../../../modules/nvf/module.nix
    ../../../hardware/machines/cwest-nixos-macbook/hardware.nix
    ../../../modules/desktop-environment/gnome.nix
    ../../../modules/libre-office.nix
    ../../../modules/automated-garbage-collection.nix
    ../../../modules/desktop-environment/hyprland.nix
    nvf.nixosModules.default
    home-manager.nixosModules.default
    nixos-hardware.nixosModules.apple-t2
  ];
}
