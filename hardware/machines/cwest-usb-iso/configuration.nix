{ home-manager, ... }:
{
  services.displayManager.defaultSession = "hyprland";

  home-manager = {
    extraSpecialArgs = {
      inherit home-manager;
    };
    users = {
      nixos = import ./home.nix;
    };
  };
}
