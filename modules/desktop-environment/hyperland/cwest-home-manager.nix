{ lib, pkgs, ... }:
{
  programs.waybar = {
        enable = true;
        };

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";
      "$smod" = "SUPER_SHIFT";

      bind =
        [
          ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
          "$mod, N, submap, launch"
          "$smod, Q, killactive,"
          "$mod, return, exec, ${pkgs.kitty}/bin/kitty"
          "$smod, E, exit,"
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
          "$mod, 0, workspace, ${toString 10}"
          "$mod SHIFT, 0, movetoworkspace, ${toString 10}"
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList (
              i:
              let
                ws = i + 1;
              in
              [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            ) 9
          )
        );
    };
    plugins = with pkgs.hyprlandPlugins; [
      hyprbars
    ];
    extraConfig =
      let
        reset = "hyprctl dispatch submap reset;";
      in
      ''
        submap = launch
                bind = , B, exec, ${reset} ${pkgs.brave}/bin/brave
                bind = , S, exec, ${reset} ${pkgs.spotify}/bin/spotify
                bind = , catchall, submap, reset
        submap = reset


        # What follows was copied straight from the default config

        # https://wiki.hyprland.org/Configuring/Variables/#general
        general {
            gaps_in = 5
            gaps_out = 20

            border_size = 2

            # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
            col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
            col.inactive_border = rgba(595959aa)

            # Set to true enable resizing windows by clicking and dragging on borders and gaps
            resize_on_border = false

            # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
            allow_tearing = false

            layout = dwindle
        }

        # https://wiki.hyprland.org/Configuring/Variables/#decoration
        decoration {
            rounding = 10
            rounding_power = 2

            # Change transparency of focused and unfocused windows
            active_opacity = 1.0
            inactive_opacity = 1.0

            shadow {
                enabled = true
                range = 4
                render_power = 3
                color = rgba(1a1a1aee)
            }

            # https://wiki.hyprland.org/Configuring/Variables/#blur
            blur {
                enabled = true
                size = 3
                passes = 1

                vibrancy = 0.1696
            }
        }

        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        dwindle {
            pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
            preserve_split = true # You probably want this
        }

        # https://wiki.hyprland.org/Configuring/Variables/#input
        input {
            kb_layout = us
            kb_variant =
            kb_model =
            kb_options =
            kb_rules =

            follow_mouse = 1

            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

            touchpad {
                natural_scroll = false
            }
        }

        bindm = $mod, mouse:272, movewindow
        bindm = $mod, mouse:273, resizewindow

        # Laptop multimedia keys for volume and LCD brightness
        bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
        bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-


        # Requires playerctl
        bindl = , XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next
        bindl = , XF86AudioPause, exec, ${pkgs.playerctl}/bin/playerctl play-pause
        bindl = , XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause
        bindl = , XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous
        exec-once = ${pkgs.waybar}/bin/waybar
      '';
  };
}
