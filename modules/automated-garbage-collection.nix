{ ... }:
{
  # this can be done manually instead with
  # nix-collect-garbage -d --delete-older-than 21d
  nix.gc.automatic = true;
  nix.gc.dates = "monthly";
  nix.gc.options = "--delete-older-than 21d";
  nix.settings.auto-optimise-store = true;
}
