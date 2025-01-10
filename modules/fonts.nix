{ config, pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts._0xproto
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      nerd-fonts.go-mono
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode" ];
      };
    };
  };
}
