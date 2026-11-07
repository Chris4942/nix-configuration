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
    };
  };
  home.file.".cache/noctalia/wallpapers.json" = {
    text = builtins.toJSON {
      defaultWallpaper = cwest.background;
      wallpapers = { };
    };
  };
}
