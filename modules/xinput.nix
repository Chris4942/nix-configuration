{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    linuxKernel.packages.linux_zen.xone
  ];

  # Enable drivers for xbox controllers
  hardware.xone.enable = true;
}
