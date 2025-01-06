{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.file."${config.home.homeDirectory}/gs.sh".text = builtins.readFile ./launch.sh;

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  environment.systemPackages = with pkgs; [ mangohud ];
  environment.loginShellInit = ''
    [[ "$(tty)" = "/dev/tty1" ]] && ./gs.sh
  '';
}
