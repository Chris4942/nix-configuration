{ pkgs, ... }:
{
  services.jellyfin.enable = true;
  services.jellyfin.openFirewall = true;
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
    # TODO:currently broken download link, will probably be fixed in future versions of nixpkgs
    # pkgs.makemkv # provides makemkvcon (even though nixos search doesn't say it does)
    pkgs.dvdbackup
  ];

  networking.firewall.allowedTCPPorts = [ 8096 ];
}
