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
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations = {
        cwest-nixos-1 = import ./hardware/machines/cwest-nixos-1 inputs;

        # This calls your `default.nix` file in the directory below.
        # It defines a function that is called with the argument inputs which is the argument to the outputs function that we're in currently
        nadaph-nixos-1 = import ./hardware/machines/nadaph-nixos-1 inputs;
        exampleIso = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { pkgs, modulesPath, ... }:
              {
                imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
                environment.systemPackages = [ pkgs.neovim ];
              }
            )
          ];
        };
      };
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
    };
}
