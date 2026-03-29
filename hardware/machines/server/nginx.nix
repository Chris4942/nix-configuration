{ pkgs, ... }:
let
  host = "west-server";
  nginxPort = "8080";
  immichPort = 2283;
in
{
  environment.systemPackages = [ pkgs.nextcloud32 ];
  # This only is set during the initial set up script
  # This is overridden in practice
  environment.etc."nextcloud-admin-pass".text = "yak_examples6CHEROKEE";
  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    home = "/mnt/main/nextcloud";
    hostName = "nextcloud.${host}";
    settings = {
      overwriteprotocol = "http";
      overwritehost = "nextcloud.${host}:${nginxPort}";
      overwrite.cli.url = "http://nextcloud.${host}:${nginxPort}/";
    };
  };
  services.nginx.virtualHosts = {
    "nextcloud.${host}" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 80;
        }
      ];

      locations."/" = {
        proxyPass = "http://127.0.0.1:80";
        extraConfig = ''
          proxy_set_header Host $host;
          proxy_set_header X-Forwarded-Proto http;
        '';
      };
    };

    "immich.${host}" = {
      listen = [
        {
          addr = "0.0.0.0";
          port = 80;
        }
      ];

      locations."/" = {
        proxyPass = "http://127.0.0.1:${builtins.toString immichPort}";
        proxyWebsockets = true;
        recommendedProxySettings = true;
      };
    };
  };
  services.immich = {
    enable = true;
    host = "127.0.0.1";
    openFirewall = true;
    port = 2283;
  };
}
