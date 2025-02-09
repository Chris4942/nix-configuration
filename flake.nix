{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nvf,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        cwest-nixos-1 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit home-manager nvf;
            rootUser = rec {
              name = "cwest";
              description = "Chris West";
              homeDirectory = "/home/${name}";
            };
          };
          modules = [
            ./hardware/machines/cwest-nixos-1/configuration.nix
            ./modules/fonts.nix
            ./modules/localization/new-york.nix
            ./modules/monitor-configuration.nix
            ./modules/bash.nix
            ./modules/syncthing.nix
            ./modules/nix-ld.nix
            ./modules/xinput.nix
            ./modules/steam.nix
            ./modules/audio.nix
            ./modules/nvf/module.nix
            ./hardware/machines/cwest-nixos-1/hardware.nix
            ./hardware/drivers/amdgpu.nix
            ./modules/desktop-environment/gnome.nix
            ./modules/desktop-environment/sway.nix
            nvf.nixosModules.default
            home-manager.nixosModules.default
          ];
        };
        guest-nixos = nixpkgs.lib.nixosSystem {
          modules = [
            ./hardware/machines/guest/configuration.nix
            ./modules/fonts.nix
            ./modules/localization/denver.nix
            ./modules/bash.nix
            ./modules/nix-ld.nix
            ./modules/xinput.nix
            ./modules/steam.nix
            ./modules/audio.nix
            # ./hardware/machines/cwest-nixos-1/hardware.nix # replace this with your own hardware configuration file and uncomment
            ./hardware/drivers/amdgpu.nix
            ./modules/desktop-environment/gnome.nix # replace this with kde.nix if you prefer
          ];
        };
      };
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
    };
}
