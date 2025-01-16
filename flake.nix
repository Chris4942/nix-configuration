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
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit home-manager nvf;
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
          ./modules/nvf/module.nix
          nvf.nixosModules.default
          home-manager.nixosModules.default
        ];
      };
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
    };
}
