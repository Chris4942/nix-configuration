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
    rootUser = rec {
      name = "cwest";
      description = "Chris West";
      homeDirectory = "/home/${name}";
    };
  };

  modules = [
    ./configuration.nix
    ./hardware.nix
    ../../../modules/fonts.nix
    ../../../modules/localization/new-york.nix
    ../../../modules/bash.nix
    ../../../modules/nix-ld.nix
    ../../../modules/xinput.nix
    ../../../modules/steam.nix
    ../../../modules/audio.nix
    ../../../modules/nvf/module.nix
    ../../../modules/desktop-environment/gnome.nix
    ../../../modules/desktop-environment/sway.nix
    ../../../modules/libre-office.nix
    nvf.nixosModules.default
    home-manager.nixosModules.default
  ];
}
