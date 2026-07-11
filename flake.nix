{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    noctalia-flake = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      nvf,
      nixos-hardware,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        # Desktop with walnut inlay in the front
        walnut = import ./hardware/machines/walnut inputs;
        # Macbook pro
        virginia-greening = import ./hardware/machines/virginia-greening inputs;
        cwest-usb = import ./hardware/machines/cwest-usb inputs;
        cwest-usb-iso = import ./hardware/machines/cwest-usb-iso inputs;
        server = import ./hardware/machines/server inputs;
      };

      homeConfigurations = {
        "deck" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            nvf.homeManagerModules.default
            ./users/deck.nix
          ];
        };
      };

      formatter.x86_64-linux = pkgs.nixfmt-tree;
    };
}
