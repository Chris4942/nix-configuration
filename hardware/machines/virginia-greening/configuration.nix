{
  pkgs,
  home-manager,
  noctalia-flake,
  ...
}:
{
  imports = [
    home-manager.nixosModules.default
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "virginia-greening"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  services.xserver.enable = true;
  services.tailscale.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  home-manager = {
    extraSpecialArgs = {
      inherit home-manager noctalia-flake;
    };
    users = {
      cwest = import ./users/cwest.nix;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cwest = {
    isNormalUser = true;
    description = "Chris West";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = import ../../../packages/lists/cwest-user-standard.nix pkgs ++ [ pkgs.runelite ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages =
    import ../../../packages/lists/cwest-system-standard.nix pkgs
    ++ (with pkgs; [
      seafile-client
      libinput
      evtest
      evemu
    ]);

  virtualisation.docker.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
