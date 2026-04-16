{ pkgs, ... }:
let
  envFile = pkgs.fetchurl {
    url = "https://manual.seafile.com/13.0/repo/docker/ce/env";
    sha256 = "sha256-PqasLa8c8PwqxlYsgfM1r1FK7zL5mQ4p571IvbPWn4U=";
  };

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

  seafile-docker-compose = pkgs.stdenv.mkDerivation {
    pname = "seafile-docker-config";
    version = "13.0";

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out

      cp ${envFile} $out/.env
      cp ${seafileYml} $out/seafile-server.yml
      cp ${seadocYml} $out/seadoc.yml
      cp ${caddyYml} $out/caddy.yml
    '';
  };
in
{
  systemd.tmpfiles.rules = [
    "L /opt/seafile - - - - ${seafile-docker-compose}"
    "L /opt/seafile-data - - - - /mnt/main/seafile/data"
    "L /opt/seafile-mysql - - - - /mnt/main/seafile/data"
  ];
}
