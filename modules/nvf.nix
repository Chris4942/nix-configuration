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
        useSystemClipboard = true;
        lsp = {
          enable = true;
          mappings = {
            goToDefinition = "gd";
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
        tabline.nvimBufferline.enable = true;
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
          {
            key = "<leader>bb";
            mode = "n";
            silent = true;
            action = ":b#<CR>";
            desc = "open previous buffer";
          }
          {
            key = "<C-h>";
            mode = "n";
            silent = true;
            action = "<C-w>h";
            desc = "move to left window";
          }
          {
            key = "<C-j>";
            mode = "n";
            silent = true;
            action = "<C-w>j";
            desc = "move to left window";
          }
          {
            key = "<C-k>";
            mode = "n";
            silent = true;
            action = "<C-w>k";
            desc = "move to left window";
          }
          {
            key = "<C-l>";
            mode = "n";
            silent = true;
            action = "<C-w>l";
            desc = "move to left window";
          }
          {
            key = "<leader>fy";
            mode = "n";
            silent = true;
            action = ":let @+ = expand('%:.')<cr>";
            desc = "copy relative path to clipboard";
          }
          {
            key = "<leader>fY";
            mode = "n";
            silent = true;
            action = ":let @+ = expand('%:p')<cr>";
            desc = "copy absolute path to clipboard";
          }
        ];
      };
    };
  };
}
