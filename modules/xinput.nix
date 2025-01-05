{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xboxdrv
    linuxKernel.packages.linux_zen.xone
  ];

  # Enable drivers for xbox controllers
  hardware.xone.enable = true;
}
