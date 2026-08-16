{
  # this can be done manually instead with
  # nix-collect-garbage -d --delete-older-than 14d
  #
  # However, old generations will still stick around unless you run as well
  # sudo nix-env --delete-generations 14d --profile /nix/var/nix/profiles/system
  nix.gc.automatic = true;
  nix.gc.dates = "monthly";
  nix.gc.options = "--delete-older-than 14d";
  nix.settings.auto-optimise-store = true;
}
