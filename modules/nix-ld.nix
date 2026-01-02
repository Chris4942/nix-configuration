{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    libusb1
    glibc

    # Everything after this is required to run tracy,
    # a sketcher binary I downloaded from the internet :)
    freetype
    dbus
    glfw
    gtk3
    curl
    gcc.cc.lib
    libGL
    mesa
    xorg.libX11
    xorg.libXcursor
    xorg.libXi
    xorg.libXrandr
  ];
}
