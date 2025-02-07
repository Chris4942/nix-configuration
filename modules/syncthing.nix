{ pkgs, rootUser, ... }:
{
  services.syncthing = {
    enable = true;
    user = rootUser.name;
    dataDir = "${rootUser.homeDirectory}/west-sync/";
    configDir = "${rootUser.homeDirectory}/.config/syncthing";
  };

  environment.systemPackages = with pkgs; [ syncthing ];
}
