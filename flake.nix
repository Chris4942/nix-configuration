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
            ./hardware/machines/amd-gpu.nix
            ./modules/desktop-environment/gnome.nix
            ./modules/desktop-environment/sway.nix
            nvf.nixosModules.default
            home-manager.nixosModules.default
          ];
        };
      };
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
    };
}
