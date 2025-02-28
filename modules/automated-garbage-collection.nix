{ ... }:
{
  # this can be done manually instead with
  # nix-collect-garbage -d --delete-older-than 30d
  nix.gc.automatic = true;
  nix.gc.dates = "daily";
  nix.gc.options = "--delete-older-than 30d";
  nix.settings.auto-optimise-store = true;
}
