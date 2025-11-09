{ pkgs, ... }:
{
  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
    pkgs.makemkv # provides makemkvcon (even though nixos search doesn't say it does)
    pkgs.dvdbackup
  ];

  networking.firewall.allowedTCPPorts = [ 8096 ];
}
