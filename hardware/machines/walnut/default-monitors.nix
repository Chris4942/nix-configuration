{ ... }:
{
  systemd.tmpfiles.rules =
    let
      monitorsXml = builtins.path {
        path = ./default-monitors.xml;
        name = "monitorsXml";
      };
    in
    [
      "L+ /var/lib/gdm/seat0/config/monitors.xml - gdm gdm - ${monitorsXml}"
    ];
}
