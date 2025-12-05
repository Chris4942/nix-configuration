{ ... }:
let
  configs = builtins.path {
    path = ./configs;
    name = "quickshell-configs";
  };
in
{
  programs.quickshell = {
    enable = true;
    activeConfig = configs;
    systemd.enable = true;
  };
}
