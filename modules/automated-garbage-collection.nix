{ ... }:
{
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 30d";
  nix.settings.auto-optimise-store = true;
}
