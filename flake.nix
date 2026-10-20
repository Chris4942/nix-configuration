{
  description = "Nixos config flake";

  inputs = {
    # Unstable because the version of immich on stable is unsecure.
    # Can go back to stable after 26.11
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    noctalia-flake = {
      url = "github:noctalia-dev/noctalia/legacy-v4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    cwest-niri = {
      url = "github:Chris4942/cwest-niri";
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
      cwest-niri,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      cwest-niri-overlay = final: prev: {
        cwest-niri = cwest-niri.packages.${final.stdenv.hostPlatform.system}.cwest-niri;
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ cwest-niri-overlay ];
      };
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

      nixosModules.cwest-niri = { ... }: {
        nixpkgs.overlays = [
          cwest-niri-overlay
        ];
      };

      homeConfigurations = {
        "deck" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            nvf.homeManagerModules.default
            ./users/deck
          ];
        };
      };

      formatter.x86_64-linux = pkgs.nixfmt-tree;
    };
}
