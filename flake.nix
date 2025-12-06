{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
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
        cwest-nixos-1 = import ./hardware/machines/cwest-nixos-1 inputs;
        cwest-nixos-macbook = import ./hardware/machines/cwest-nixos-macbook inputs;
        cwest-usb = import ./hardware/machines/cwest-usb inputs;
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
