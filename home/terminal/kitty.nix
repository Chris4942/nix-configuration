{
  config,
  pkgs,
  home-manager,
  lib,
  ...
}:
{
  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 13;
    };

    # consistent with other terminal emulators
    keybindings = {
      "ctrl+shift+f" = "show_scrollback"; # search in the current window
    };

    settings = {
      background_opacity = "0.93";
      enable_audio_bell = false;
      tab_bar_edge = "top";
    };
  };
}
