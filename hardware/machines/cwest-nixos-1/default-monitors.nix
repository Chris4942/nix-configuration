{ ... }:
let
  monitors-config = {
    source = ./default-monitors.xml;
    mode = "0644";
    user = "gdm";
    group = "gdm";
    target = "/var/lib/gdm/.config/monitors.xml";
  };
in
{
  environment.etc."gdm/monitors.xml" = monitors-config;
  environment.etc."xdg/monitors.xml" = monitors-config;
}
