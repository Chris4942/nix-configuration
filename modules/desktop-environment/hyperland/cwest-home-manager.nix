{ lib, pkgs, ... }:
{
  enable = true;
  settings = {
    "$mod" = "SUPER";
    bind =
      [
        ", Print, exec, ${pkgs.grimblast}/bin/grimblast copy area"
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
  # extraConfig = ''
  #   $mod, N, submap, launch
  #
  #   submap = launch
  #   bind = b, exec, ${pkgs.brave}/bin/brave
  # '';
}
