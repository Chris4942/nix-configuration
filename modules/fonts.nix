{ config, pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override {
        fonts = [
          "FiraCode"
          "DroidSansMono"
        ];
      })
    ];

    fontconfig = {
      defaultFonts = {
        monospace = [ "FiraCode" ];
      };
    };
  };
}
