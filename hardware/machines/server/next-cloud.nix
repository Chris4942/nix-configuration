{
  pkgs,
  ...
}:
{
  # This is the default password that will be overridden
  environment.etc."nextcloud-admin-pass".text = "yak_examples6CHEROKEE";
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostname = "localhost";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
  };
}
