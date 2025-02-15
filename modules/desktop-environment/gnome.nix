{ ... }:
{
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # you may need to run the following command if switching from plasma. There might be a way to bake this into the nix config so that it's not required manually.
  # dconf reset /org/gnome/desktop/interface/cursor-theme
}
