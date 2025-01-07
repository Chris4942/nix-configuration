{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [

    neovim-node-client

  ];
  programs.nvf = {
    enable = true;
    # your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };
        viAlias = false;
        vimAlias = true;
        lsp = {
          enable = true;
        };
        languages = {
          nix = {
            enable = true;
          };
        };
        lazy.plugins = {
        };
        extraPlugins = with pkgs.vimPlugins; {
          harpoon = {
            package = harpoon;
            setup = "require('harpoon').setup {}";
          };
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
      };
    };
  };
}
