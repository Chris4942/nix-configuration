{
  config,
  pkgs,
  home-manager,
  lib,
  ...
}:
let
  random-image = "find /home/cwest/.backgrounds | rg \"\\.(jpg|png)$\" | shuf -n 1";
  set-random-image = "swaymsg output \"*\" bg `${random-image}` fill";
in
{
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
              u = "exec ${pkgs.blueman}/bin/blueman-manager" + toDefault;
            }
            // withEscape;
            resize = lib.mkOptionDefault withEscape;
            lock = {
              l = "exec swaylock" + toDefault;
              x = "exec swaylock & systemctl suspend" + toDefault;
            }
            // withEscape;
          };
        startup = [
          {
            always = true;
            command = set-random-image;
          }
        ];
        terminal = "${pkgs.kitty}/bin/kitty";
        defaultWorkspace = "workspace number 1";
      };
    };

  services.mako = {
    enable = true;
    settings.default-timeout = 10 * 1000;
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
}
