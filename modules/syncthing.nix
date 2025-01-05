{ pkgs, ... }: {
  services.syncthing = {
    enable = true;
    user = "cwest";
    dataDir = "/home/cwest/west-sync/";
    configDir = "/home/cwest/.config/syncthing";
  };

  environment.systemPackages = with pkgs; [
    syncthing
  ];
}
