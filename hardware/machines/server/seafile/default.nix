{ pkgs, ... }:
let
  seafileYml = pkgs.fetchurl {
    url = "https://manual.seafile.com/13.0/repo/docker/ce/seafile-server.yml";
    sha256 = "sha256-8lWsiMit+j20dcPGvH4XJHJbNkem53LGF/Y9raZGbQk=";
  };

  seadocYml = pkgs.fetchurl {
    url = "https://manual.seafile.com/13.0/repo/docker/seadoc.yml";
    sha256 = "sha256-NZpwzABtfoZ8jy7lt4U+OsMnf51mmplnIziWM4D0wNQ=";
  };

  caddyYml = pkgs.fetchurl {
    url = "https://manual.seafile.com/13.0/repo/docker/caddy.yml";
    sha256 = "sha256-pfJuflqyyYio3AVBEibjxHyNPKvzXQUD6HkaVc/EpTI=";
  };

  seafile-docker-compose-directory = pkgs.stdenv.mkDerivation {
    pname = "seafile-docker-config";
    version = "13.0";

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out
      cp ${./.env} $out/.env
      cp ${seafileYml} $out/seafile-server.yml
      cp ${seadocYml} $out/seadoc.yml
      cp ${caddyYml} $out/caddy.yml
    '';
  };
in
{
  systemd.services.seafile = {
    description = "Seafile Docker Compose";
    after = [
      "network.target"
      "docker.service"
    ];
    requires = [ "docker.service" ];

    serviceConfig = {
      Type = "oneshot";
      WorkingDirectory = "${seafile-docker-compose-directory}";
      ExecStart = "${pkgs.docker-compose}/bin/docker-compose up -d";
      ExecStop = "${pkgs.docker-compose}/bin/docker-compose down";
      RemainAfterExit = true;
    };

    wantedBy = [ "multi-user.target" ];
  };
}
