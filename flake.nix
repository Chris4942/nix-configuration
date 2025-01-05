{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        ./modules/fonts.nix
        ./modules/localization.nix
        ./modules/monitor-configuration.nix
        ./modules/bash.nix
        ./modules/syncthing.nix
        ./modules/nix-ld.nix
        ./modules/xinput.nix
        # inputs.home-manager.nixosModules.default
      ];
    };
  };
}
