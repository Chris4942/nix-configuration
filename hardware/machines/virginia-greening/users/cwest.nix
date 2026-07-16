{ ... }: {
  imports = [
    ../../../../users/cwest.nix
  ];

  cwest.hyprland.extraBind = [
    "$mod, M, exec, sudo ${../toggle-mouse.sh}"
  ];
}
