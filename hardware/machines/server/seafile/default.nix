{ pkgs, ... }:
let
  srcDir = ./docker-compose;

  files = builtins.attrNames (builtins.readDir srcDir);

  linkRules = map (name: "L+ /opt/seafile/${name} - - - - ${srcDir}/${name}") files;
in
{
  systemd.tmpfiles.rules = [
    "d /opt/seafile 0755 root root -"
    "d /opt/seafile 0755 root root -"
  ]
  ++ linkRules;

  systemd.services.seafile = {
    enable = true;
    description = "Seafile Docker Compose";
    after = [
      "network.target"
    ];

    serviceConfig = {
      Type = "oneshot";
      EnvironmentFile = "/mnt/main/seafile/secrets.env";
      WorkingDirectory = "${./docker-compose}";
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose up -d";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose down";
      RemainAfterExit = true;
    };

    wantedBy = [ "multi-user.target" ];
  };
  networking.firewall.allowedTCPPorts = [
    8011
    8082
    8000
  ];
}
