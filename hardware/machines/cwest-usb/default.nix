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
    ./iso.nix
    # Enable devices which are usually scanned, because we don't know the
    # target system.
    "${nixpkgs}/nixos/modules/installer/scan/detected.nix"
    # ../installer/scan/detected.nix
    "${nixpkgs}/nixos/modules/installer/scan/not-detected.nix"
    # ../installer/scan/not-detected.nix

    # Allow "nixos-rebuild" to work properly by providing
    # /etc/nixos/configuration.nix.
    "${nixpkgs}/nixos/modules/profiles/clone-config.nix"
    # ./clone-config.nix

    # Include a copy of Nixpkgs so that nixos-install works out of
    # the box.
    # ../installer/cd-dvd/channel.nix
    "${nixpkgs}/nixos/modules/installer/cd-dvd/iso-image.nix"
                # "${nixpkgs}/nixos/modules/profiles/installation-device.nix"
    "${nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    ./boot.nix
    ./configuration.nix
    ./hardware.nix
    ../../../modules/fonts.nix
    ../../../modules/localization/new-york.nix
    ../../../modules/bash.nix
    ../../../modules/nix-ld.nix
    ../../../modules/xinput.nix
    ../../../modules/steam.nix
    ../../../modules/audio.nix
    ../../../modules/nvf/module.nix
    ../../../modules/desktop-environment/gnome-iso.nix
    ../../../modules/desktop-environment/sway.nix
    ../../../modules/libre-office.nix
    nvf.nixosModules.default
    home-manager.nixosModules.default
  ];
}
