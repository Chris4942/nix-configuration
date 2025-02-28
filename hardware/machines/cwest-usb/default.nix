{ nixpkgs, ... }: nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (
              { pkgs, modulesPath, ... }:
              {
                imports = [ (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix") ];
                environment.systemPackages = [ pkgs.neovim ];
              }
            )
                # ../cwest-nixos-1/configuration.nix
          ];
        }
