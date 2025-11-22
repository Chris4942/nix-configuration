{
  pkgs,
  ...
}:
{
  # This is the default password that will be overridden

  environment.systemPackages = [ pkgs.nextcloud31 ];
  environment.etc."nextcloud-admin-pass".text = "yak_examples6CHEROKEE";
  networking.firewall.allowedTCPPorts = [ 80 ];
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    hostName = "localhost";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    settings.trusted_domains = [
      "192.168.1.207"
    ];
  };
}
