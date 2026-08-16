{
  imports = [
    ../../../../users/cwest.nix
  ];

  cwest.hyprland.extraBind = [
    "$mod, M, exec, sudo ${../toggle-mouse.sh}"
  ];

  cwest.noctalia.background = ../../../../data/backgrounds/wallhaven-q6ed85_2560x1440.png;
}
