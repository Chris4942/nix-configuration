{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    neovim-node-client
  ];
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };
        viAlias = false;
        vimAlias = true;
        binds.whichKey.enable = true;
        lsp.enable = true;
        comments.comment-nvim.enable = true;
        filetree.neo-tree.enable = true;
        languages = {
          enableLSP = true;
          enableTreesitter = true;
          nix.enable = true;
          rust = {
            enable = true;
            lsp.enable = true;
            crates.enable = true;
          };
          python.enable = true;
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
