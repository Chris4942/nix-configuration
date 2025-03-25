{
  config,
  pkgs,
  home-manager,
  lib,
  rootUser,
  ...
}@inputs:
let
  random-image = "find /${rootUser.homeDirectory}/.backgrounds | rg \"\\.(jpg|png)$\" | shuf -n 1";
  set-random-image = "swaymsg output \"*\" bg `${random-image}` fill";
in

rec {
  imports = [
    ../modules/desktop-environment/hyperland/cwest-home-manager.nix
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
      options = [ "--cmd cd" ];
      enable = true;
    };
    kitty.enable = true;
  };
  # wayland.windowManager.hyprland = import ../modules/desktop-environment/hyperland/cwest-home-manager.nix inputs;

  wayland.windowManager.sway =
    let
      mod = "Mod4";
    in
    {
      enable = true;
      config = {
        modifier = mod;
        gaps = {
          inner = 30;
          outer = 5;
        };
        keybindings = lib.mkOptionDefault {
          # requires pulseaudio packages
          # TODO: figure out how to get add that in here so that if it's not provided elsewhere this will pull it in as a dependency
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +7%";
          "shift+XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +1%";
          "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -7%";
          "shift+XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -1%";
          "XF86AudioPlay" =
            "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause";
          "XF86AudioNext" =
            "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Next";
          "XF86AudioPrev" =
            "exec dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Previous";

          "${mod}+n" = "mode launcher";
          "${mod}+x" = "mode lock";
        };
        modes =
          let
            withEscape = {
              Escape = "mode \"default\"";
            };
            toDefault = ", mode \"default\"";
          in
          lib.mkOptionDefault {
            launcher = {
              # b = "exec $BROWSER" + toDefault;
              b = "exec brave" + toDefault;
              # s = "exec $MUSIC_PLAYER" + toDefault;
              s = "exec spotify" + toDefault;
              # a = "exec $DISPLAY_MANAGER" + toDefault;
              a = "exec arandr" + toDefault;
              # p = "exec $AUDIO_CONTROLLER" + toDefault;
              d = "exec discord" + toDefault;
              p = "exec pavucontrol" + toDefault;
              q = "exec ${set-random-image}" + toDefault;
            } // withEscape;
            resize = lib.mkOptionDefault withEscape;
            lock = {
              l = "exec swaylock" + toDefault;
              x = "exec swaylock & systemctl suspend" + toDefault;
            } // withEscape;
          };
        startup = [
          {
            always = true;
            command = set-random-image;
          }
        ];
        terminal = "${pkgs.foot}/bin/foot";
        defaultWorkspace = "workspace number 1";
      };
    };

  services.mako = {
    enable = true;
    defaultTimeout = 10 * 1000;
  };

  programs.swaylock = {
    enable = true;
    settings = lib.mkOptionDefault {
      image = "`${random-image}`";
      ring-color = "96d17e";
      ring-ver-color = "7ea6d1";
      ring-wrong-color = "f35636";
      line-color = "1a191a";
      font = "GoMono";
    };
  };

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
    TERMINAL = "${foot}/bin/foot";
    BROWSER = "${brave}/bin/brave";
    MUSIC_PLAYER = "spotify";
    DISPLAY_MANAGER = "${arandr}/bin/arandr";
    AUDIO_CONTROLLER = "${pavucontrol}/bin/pavucontrol";
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
