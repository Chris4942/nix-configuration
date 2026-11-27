{ pkgs, ... }: {
  programs.wlr-which-key = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font 12";
      background = "#282828d0";
      color = "#fbf1c7";
      border = "#8ec07c";
      separator = " ➜ ";
      border_width = 2;
      corner_r = 10;
      padding = 15;
      rows_per_column = 5;
      column_padding = 25;
      anchor = "center";
      margin_right = 0;
      margin_bottom = 0;
      margin_left = 0;
      margin_top = 0;
      menu = [
        {
          key = "b";
          desc = "Browser";
          cmd = "${pkgs.firefox}/bin/firefox";
        }
        {
          key = "d";
          desc = "Discord";
          cmd = "${pkgs.discord}/bin/discord";
        }
        {
          key = "p";
          desc = "Audio Controller";
          cmd = "${pkgs.pavucontrol}/bin/pavucontrol";
        }
        {
          key = "l";
          desc = "Bluetooth Manager";
          cmd = "${pkgs.blueman}/bin/blueman-manager";
        }
      ];
    };
  };
}
