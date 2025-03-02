# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  home-manager,
  rootUser,
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

  networking.hostName = "nixos"; # Define your hostname.
  #
  # # Enable networking
  networking.networkmanager.enable = true;

  services.xserver.enable = true;

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
      inherit home-manager;
      inherit rootUser;
    };
    users = {
      "${rootUser.name}" = import ../../../users/root-user.nix;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${rootUser.name} = {
    isNormalUser = true;
    password = "foobar";
    description = rootUser.description;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = import ../../../packages/lists/cwest-user-standard.nix pkgs;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = import ../../../packages/lists/cwest-system-standard.nix pkgs;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
