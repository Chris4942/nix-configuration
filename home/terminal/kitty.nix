{
  config,
  pkgs,
  home-manager,
  lib,
  rootUser,
  ...
}:
{
  programs.kitty = {
    enable = true;
    # kitty has catppuccin theme built-in,
    # all the built-in themes are packaged into an extra package named `kitty-themes`
    # and it's installed by home-manager if `theme` is specified.
    themeFile = "Catppuccin-Mocha";
    font = {
      name = "JetBrainsMono Nerd Font";
      # use different font size on macOS
      size = if pkgs.stdenv.isDarwin then 14 else 13;
    };

    # consistent with other terminal emulators
    keybindings = {
      "ctrl+shift+f" = "show_scrollback"; # search in the current window
    };

    settings = {
      background_opacity = "0.93";
      macos_option_as_alt = true; # Option key acts as Alt on macOS
      enable_audio_bell = false;
      tab_bar_edge = "top"; # tab bar on top
    };

    # macOS specific settings
    darwinLaunchOptions = [ "--start-as=maximized" ];
  };
}
