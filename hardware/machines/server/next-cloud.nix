{
  pkgs,
  ...
}:
{
  # This is the default password that will be overridden

  environment.systemPackages = [ pkgs.nextcloud31 ];
  environment.etc."nextcloud-admin-pass".text = "yak_examples6CHEROKEE";
  networking.firewall.allowedTCPPorts = [
    80
    8080
  ];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "localhost";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    home = "/mnt/main/nextcloud";

    settings =
      let
        prot = "http"; # or https
        host = "192.168.1.219";
        dir = "/";
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

    # Optional: listen on LAN IP
    # (by default Nginx listens on all interfaces)
    # listenAddresses = [ "192.168.1.219" ];

    virtualHosts = {
      # You can use your LAN IP as the "server_name" for local access
      "192.168.1.219" = {
        # Listen on port 80
        listen = [
          {
            addr = "0.0.0.0";
            port = 8080;
          }
        ];

        # Reverse proxy all requests to Nextcloud on localhost:80
        locations."/" = {
          proxyPass = "http://127.0.0.1:80";
          extraConfig = ''
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-NginX-Proxy true;
            proxy_set_header X-Forwarded-Proto http;
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
            proxy_redirect off;
          '';

          # Set headers so Nextcloud knows the real client IP and protocol
          # proxySetHeader = [
          #   "Host $host"
          #   "X-Real-IP $remote_addr"
          #   "X-Forwarded-For $proxy_add_x_forwarded_for"
          #   "X-Forwarded-Proto $scheme"
          # ];
        };
      };
    };
  };
}
