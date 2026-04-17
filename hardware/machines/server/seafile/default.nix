{ pkgs, ... }:
{
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
}
