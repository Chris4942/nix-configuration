{ ... }:
{
  # Enable the GNOME Desktop Environment.
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  # you may need to run the following command if switching from plasma. There might be a way to bake this into the nix config so that it's not required manually.
  # dconf reset /org/gnome/desktop/interface/cursor-theme
}
