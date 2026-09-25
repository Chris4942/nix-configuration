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
      {
        url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/main/lists/all_domains.txt";
        type = "block";
        enabled = true;
        description = "Pi-hole Optimized Blocklists";
      }
      {
        url = "https://media.githubusercontent.com/media/zachlagden/Pi-hole-Optimized-Blocklists/main/lists/nsfw.txt";
        type = "block";
        enabled = true;
        description = "Pi-hole Optimized Blocklists NSFW";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ "443s" ];
  };

  networking.firewall.allowedTCPPorts = [ 443 ];
}
