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
    (
      { pkgs, modulesPath, ... }:
      {
        imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
        environment.systemPackages = [ pkgs.neovim ];
      }
    )
    ./hardware.nix
    ../cwest-nixos-1/configuration.nix
  ];
}
