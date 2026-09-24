{
  services.pihole-ftl = {
    enable = true;
    settings = {
      dns.upstreams = [
        "9.9.9.9"
        "1.1.1.1"
      ];
    };

    lists = [
      {
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "hagezi blocklist";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ "443s" ];
  };
}
