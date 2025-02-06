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
          formatOnSave = true;
          lightbulb.enable = true;
          lspSignature.enable = true;
          mappings = {
            goToDefinition = "gd";
            goToDeclaration = "gD";
            hover = "<leader>ch";
            renameSymbol = "<leader>cr";
            codeAction = "<leader>ca";
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
        telescope = {
          enable = true;
          setupOpts.defaults.vimgrep_arguments = [
            "${pkgs.ripgrep}/bin/rg"
            "--color=never"
            "--no-heading"
            "--with-filename"
            "--line-number"
            "--column"
            "--smart-case"
            "--hidden"
          ];
        };
        autocomplete.nvim-cmp.enable = true;
        autopairs.nvim-autopairs.enable = true;
        notes.todo-comments.enable = true;
        visuals.indent-blankline.enable = true;
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
          {
            key = "<leader>fj";
            mode = "n";
            silent = true;
            action = ":let @+ = expand('%:t')<cr>";
            desc = "Copy short file name to clipboard";
          }
          {
            key = "<leader>fe";
            mode = "n";
            silent = true;
            action = "<cmd>Neotree reveal<cr>";
            desc = "Reveal current file in file tree";
          }
          {
            key = "<leader>nh";
            mode = "n";
            silent = true;
            action = "<cmd>noh<cr>";
            desc = "Turn off search highlights (until next search)";
          }
          {
            key = "<leader>bd";
            mode = "n";
            silent = true;
            action = "<cmd>bp<bar>sp<bar>bn<bar>bd<cr>";
            desc = "Close current buffer (TODO this macro is kind of broken)";
          }
          {
            key = "<leader>bo";
            mode = "n";
            silent = true;
            action = "<cmd>%bd<bar>e#<cr>";
            desc = "Close all other bothers";
          }
          {
            key = "<C-s>";
            mode = [
              "i"
              "n"
            ];
            action = "<cmd>w<cr>";
            desc = "save current buffer ( same as `:w`)";
          }
        ] ++ import ./nvf-extension-keymaps.nix { inherit pkgs; };
      };
    };
  };
}
