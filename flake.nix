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
            ./hardware/machines/cwest-nixos-1/configuration.nix
            ./modules/fonts.nix
            ./modules/localization/new-york.nix
            ./modules/monitor-configuration.nix
            ./modules/bash.nix
            ./modules/syncthing.nix
            ./modules/nix-ld.nix
            ./modules/xinput.nix
            ./modules/steam.nix
            ./modules/audio.nix
            ./modules/nvf/module.nix
            ./hardware/machines/cwest-nixos-1/hardware.nix
            ./hardware/drivers/amdgpu.nix
            ./modules/desktop-environment/gnome.nix
            ./modules/desktop-environment/sway.nix
            nvf.nixosModules.default
            home-manager.nixosModules.default
                                                ./modules/libre-office.nix
          ];
        };

        # Nathan, feel free to change this to whatever you need
        nadaph-nixos-1 = nixpkgs.lib.nixosSystem {
          specialArgs = {
            rootUser = rec {
              # TODO:(nadaph) make sure that this is set to whatever prints out when you run `echo $NAME`
              name = "nadaph";
              # TODO:(nadaph) set this to whatever you want to display on the login page
              description = "Nathan";
              # TODO:(nadaph) make sure that this is set to whatever is printed when you run `echo $HOME`
              # in strings inside a `rec` block, `${foobar}` will be replaced with whatever `foobar` was set to earlier;
              # so in this case, ${name} is populated with "nadaph" unless you changed it
              homeDirectory = "/home/${name}";
            };
          };
          modules = [
            # This is mostly just a duplicate of my configuration file with a few cwest speceific things removed
            ./hardware/machines/nadaph-nixos-1/configuration.nix
            # This adds in some fonts. Feel free to add more if you want a particular system font
            ./modules/fonts.nix
            # I think this will give you the right time zone. I'm not using this file, so feel free to change it
            ./modules/localization/denver.nix
            # This handles linking for app images that aren't packaged with nix. If you're finding binaries from Nigerian Princes aren't working, then you probably need to add a pkg in the list in this file
            ./modules/nix-ld.nix
            # Drivers for x box controllers (and others as well)
            ./modules/xinput.nix
            # The most important one
            ./modules/steam.nix
            # This is what I've been using and it seems to work just fine
            ./modules/audio.nix
            # There is a file generated by the installer that gets put in /etc/nix/hardware-configuration.nix
            # Copy that file to the location below and run `git add .`. It won't build until you do that
            ./hardware/machines/nadaph-nixos-1/hardware.nix # TODO:(nadaph) you'll need to copy the generated hardware configuration file here for this to work
            # This module sets up your amdgpu drivers
            ./hardware/drivers/amdgpu.nix
            # I've only lightly tested this module, but I think this will get everything you need for kde set up
            ./modules/desktop-environment/kde.nix
          ];
        };
      };
      formatter.x86_64-linux = pkgs.nixfmt-rfc-style;
    };
}
