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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  services.xserver.enable = true;

  services.displayManager = {
    defaultSession = "sway";
  };
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
  security.polkit.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

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
      "${rootUser.name}" = import ./users/root-user.nix;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${rootUser.name} = {
    isNormalUser = true;
    description = "Chris West";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      neovim
      brave
      neofetch
      steam
      discord
      spotify
      wmctrl
      gimp
      foot
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    git
    openssh
    xsel
    python313
    jq
    ripgrep
    inxi
    pciutils
    tmux
    htop
    zip
    unzip
    nodejs_22
    libgcc
    tree
    grim # screenshot functionality
    slurp # screenshot functionality
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    mako # notification system developed by swaywm maintainer
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

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
