{ lib, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$mod" = "SUPER";

      bind =
        [
          ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
          "$mod, N, submap, launch"
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
      '';
  };
}
