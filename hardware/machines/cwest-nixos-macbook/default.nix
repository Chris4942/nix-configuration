{
  nixpkgs,
  home-manager,
  nvf,
  ...
}:
nixpkgs.lib.nixosSystem {
  specialArgs = {
    inherit home-manager nvf;
    rootUser = rec {
      name = "cwest";
      description = "Chris West";
      homeDirectory = "/home/${name}";
    };
  };
  modules = [
    ./configuration.nix
    ../../../modules/fonts.nix
    ../../../modules/localization/new-york.nix
    # ../../../modules/monitor-configuration.nix
    ../../../modules/bash.nix
    ../../../modules/syncthing.nix
    ../../../modules/nix-ld.nix
    ../../../modules/xinput.nix
    ../../../modules/steam.nix
    ../../../modules/audio.nix
    ../../../modules/nvf/module.nix
    ../../../hardware/machines/cwest-nixos-macbook/hardware.nix
    # ../../../hardware/drivers/amdgpu.nix
    ../../../modules/desktop-environment/gnome.nix
    ../../../modules/desktop-environment/sway.nix
    ../../../modules/libre-office.nix
    ../../../modules/automated-garbage-collection.nix
    ../../../modules/desktop-environment/hyprland.nix
    nvf.nixosModules.default
    home-manager.nixosModules.default
  ];
}
