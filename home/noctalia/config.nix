{ noctalia-flake, config, ... }:
let
  cwest = config.cwest.noctalia;
in
{
  imports = [
    noctalia-flake.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    settings = {
      bar.default = {
        start = [
          # Left
          "launcher"
          "workspaces"
          "active_window"
        ];
      };
      wallpaper.default.path = cwest.background;
    };
  };
}
