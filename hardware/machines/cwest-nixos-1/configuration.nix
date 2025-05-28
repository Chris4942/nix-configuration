# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  home-manager,
  ...
}: {
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

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
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
    };
    users = {
      cwest = import ./users/cwest.nix;
      hwest = import ./users/hwest.nix;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.cwest = {
    isNormalUser = true;
    description = "Chris West";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamers"
    ];
    packages = (import ../../../packages/lists/cwest-user-standard.nix pkgs) ++ (with pkgs; [runelite]);
  };

  users.users.hwest = {
    isNormalUser = true;
    description = "Haley West";
    packages = with pkgs; [
      steam
      brave
      discord
      spotify
      gimp
    ];
    extraGroups = [
      "gamers"
      # TODO: take these groups out after I confirm I didn't break cwest
      "wheel"
      "networkmanager"
    ];
  };

  users.groups.gamers = {};

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = import ../../../packages/lists/cwest-system-standard.nix pkgs;

  systemd.tmpfiles.rules = [
    "d /steam-library 2775 root gamers -"
  ];

  system.activationScripts.steamLibraryACLs.text = ''
    mkdir -p /steam-library
    chown root:gamers /steam-library
    chmod 2775 /steam-library
    ${pkgs.acl}/bin/setfacl -d -m u::rwx /steam-library
    ${pkgs.acl}/bin/setfacl -d -m g::rwx /steam-library
    ${pkgs.acl}/bin/setfacl -d -m o::rx /steam-library
  '';

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
