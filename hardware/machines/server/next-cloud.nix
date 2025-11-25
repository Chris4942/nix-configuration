{
  pkgs,
  ...
}:
let
  host = "192.168.1.219";
  port = "8080";
in
{
  environment.systemPackages = [ pkgs.nextcloud32 ];
  # This only is set during the initial set up script
  # This is overridden in practice
  environment.etc."nextcloud-admin-pass".text = "yak_examples6CHEROKEE";
  networking.firewall.allowedTCPPorts = [
    8080
    443
  ];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "${host}:${port}";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    home = "/mnt/main/nextcloud";

    settings =
      let
        prot = "http";
        dir = "/nextcloud";
      in
      {
        trusted_proxies = [
          host
          "127.0.0.1"
        ];
        overwriteprotocol = prot;
        overwritehost = "${host}:${port}";
        overwritewebroot = dir;
        overwrite.cli.url = "${prot}://${host}:${port}${dir}/";
        htaccess.RewriteBase = dir;
      };
  };
  services.nginx = {
    enable = true;
    virtualHosts = {
      "${host}" = {
        listen = [
          {
            addr = "0.0.0.0";
            port = 8080;
          }
        ];

        locations."/nextcloud/" = {
          proxyPass = "http://127.0.0.1:80";
          extraConfig = ''
            rewrite ^/nextcloud/(.*)$ /$1 break;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-NginX-Proxy true;
            proxy_set_header X-Forwarded-Proto http;
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
            proxy_redirect off;
          '';
        };

        extraConfig = ''
          client_max_body_size 20G;
        '';
      };
    };
  };
}
