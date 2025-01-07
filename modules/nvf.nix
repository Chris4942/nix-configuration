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
        lineNumberMode = "number";
        binds.whichKey.enable = true;
        lsp = {
          enable = true;
          mappings = {
            goToDefinition  = "gd";
            goToDeclaration = "gD";
            hover = "<leader>ch";
            renameSymbol = "<leader>cr";
          };
        };
        comments.comment-nvim.enable = true;
        filetree.neo-tree.enable = true;
        git = {
          gitsigns.enable = true;
        };
        languages = {
          enableLSP = true;
          enableTreesitter = true;
          nix.enable = true;
          rust = {
            enable = true;
            crates.enable = true;
          };
          python = {
            enable = true;
            lsp.server = "pyright";
          };
          lua.enable = true;
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
        keymaps = [
          {
            key = "<leader>r";
            mode = "n";
            silent = true;
            action = ":term<CR>";
            desc = "open terminal";
          }
        ];
      };
    };
  };
}
