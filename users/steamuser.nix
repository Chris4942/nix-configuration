{
  config,
  pkgs,
  home-manager,
  ...
}:
{
  home.username = "steamuser";
  home.homeDirectory = "/home/steamuser";

  home.stateVersion = "24.11";
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    steam
    gamescope
  ];
  home.file."${config.home.homeDirectory}/gs.sh".text = builtins.readFile ../modules/gamescope/launch.sh;

  programs.home-manager.enable = true;
}
