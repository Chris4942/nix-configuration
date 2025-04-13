{
  config,
  pkgs,
  home-manager,
  lib,
  rootUser,
  ...
}: rec {
  imports = [
    ../modules/desktop-environment/hyperland/cwest-home-manager.nix
    ../home/sway.nix
    ../home/terminal/kitty.nix
  ];
  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = rootUser.name;
  home.homeDirectory = rootUser.homeDirectory;

  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    zoxide
    pulseaudio
    brave
    arandr
    feh
    foot
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs = {
    bash.enable = true;
    waybar.enable = true;
    zoxide = {
      options = ["--cmd cd"];
      enable = true;
    };
    kitty.enable = true;
  };
  # wayland.windowManager.hyprland = import ../modules/desktop-environment/hyperland/cwest-home-manager.nix inputs;

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=15";
      };
      colors = {
        regular1 = "bb6565"; # red
        regular2 = "7ac854"; # green
      };
    };
  };

  home.file = {
    ".backgrounds/ink-splat.png".source = ../data/backgrounds/ink-splat.png;
    ".config/waybar/config".source = ../cwest/.config/waybar/config;
  };

  home.sessionVariables = with pkgs; {
    BROWSER = "${brave}/bin/brave";
    MUSIC_PLAYER = "spotify";
    DISPLAY_MANAGER = "${arandr}/bin/arandr";
    AUDIO_CONTROLLER = "${pavucontrol}/bin/pavucontrol";
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # https://github.com/blueman-project/blueman/issues/1556#issuecomment-882857426
  services.blueman-applet.enable = true;

  dconf.settings."org/blueman/general" = {
    plugin-list = ["!ConnectionNotifier"];
  };
}
