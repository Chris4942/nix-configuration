{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, ... }:
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit home-manager;
        };
        modules = [
          ./configuration.nix
          ./modules/fonts.nix
          ./modules/localization.nix
          ./modules/monitor-configuration.nix
          ./modules/bash.nix
          ./modules/syncthing.nix
          ./modules/nix-ld.nix
          ./modules/xinput.nix
          ./modules/steam.nix
          ./modules/audio.nix
          home-manager.nixosModules.default
        ];
      };
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
    };
}
