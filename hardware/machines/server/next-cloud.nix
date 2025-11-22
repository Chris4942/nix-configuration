{
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.nextcloud31 ];
  environment.etc."nextcloud-admin-pass".text = "yak_examples6CHEROKEE";
  networking.firewall.allowedTCPPorts = [
    8080
  ];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "192.168.1.219:80";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    home = "/mnt/main/nextcloud";

    settings =
      let
        prot = "http";
        host = "192.168.1.219:8080";
        dir = "/nextcloud";
      in
      {
        overwriteprotocol = prot;
        overwritehost = host;
        overwritewebroot = dir;
        overwrite.cli.url = "${prot}://${host}${dir}/";
        htaccess.RewriteBase = dir;
      };
  };
  services.nginx = {
    enable = true;
    virtualHosts = {
      "192.168.1.219" = {
        listen = [
          {
            addr = "0.0.0.0";
            port = 8080;
          }
        ];

        locations."/nextcloud/" = {
          proxyPass = "http://127.0.0.1:80";
          extraConfig = ''
            rewrite ^/nextcloud(/.*)$ $1 break;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-NginX-Proxy true;
            proxy_set_header X-Forwarded-Proto http;
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
            proxy_redirect off;
          '';
        };
      };
    };
  };
}
