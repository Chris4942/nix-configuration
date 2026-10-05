{ pkgs, ... }: {
  home = {
    # All packages that I use in the config, I'm putting here. They may already be included somewhere else, but I don't wwant this to be imported without these
    packages = with pkgs; [
      rofi
      kitty
      swaylock
    ];
  };
  home.file.".config/niri/config.kdl".source = ./config.kdl;
}
