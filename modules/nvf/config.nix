{ pkgs, ... }:
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        theme = {
          enable = true;
          name = "gruvbox";
          style = "dark";
        };
        options = {
          wrap = false;
          cursorline = true;
          cursorcolumn = true;
          # Specify bash from pkgs.bash so that if I'm running neovim from inside a nix shell, it uses that version of bash instead.
          shell = "${pkgs.bash}/bin/bash";
        };
        viAlias = false;
        vimAlias = true;
        lineNumberMode = "number";
        binds.whichKey.enable = true;
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
            listReferences = "<leader>gr";
          };
          harper-ls = {
            enable = true;
            settings = {
              userDictPath = "~/.config/harper-ls/user.txt";
              linters = {
                OrthographicConsistency = false;
                LongSentences = false;
              };
            };
          };
        };
        comments.comment-nvim.enable = true;
        filetree.neo-tree = {
          enable = true;
          setupOpts.open_files_do_not_replace_types = [ ];
        };
        git = {
          gitsigns.enable = true;
        };
        languages = {
          enableTreesitter = true;
          nix.enable = true;
          rust = {
            enable = true;
            extensions.crates-nvim.enable = true;
            lsp.opts = ''
              ['rust-analyzer'] = {
                check = {
                  command = "clippy",
                },
              },
            '';
          };
          python = {
            enable = true;
            lsp.servers = [ "pyright" ];
          };
          lua.enable = true;
          java = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
          };
          markdown.enable = true;
          sql = {
            enable = false;
            extraDiagnostics.enable = true;
            format.enable = true;
            treesitter.enable = true;
          };
          clang = {
            enable = true;
            lsp.enable = true;
          };
          ts = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            extraDiagnostics.enable = true;
          };
        };
        extraPlugins = with pkgs.vimPlugins; {
          harpoon = {
            package = harpoon2;
            setup = builtins.readFile ./lua/harpoon.lua;
          };
          # Highlight hex colors in that color
          nvim-highlight-color = {
            package = nvim-highlight-colors;
            setup = builtins.readFile ./lua/highlight-color.lua;
          };
          vim-fetch.package = vim-fetch;
        };
        statusline.lualine.enable = true;
        tabline.nvimBufferline.enable = true;
        telescope = {
          enable = true;
          extensions = [
            {
              name = "fzf";
              packages = [ pkgs.vimPlugins.telescope-fzf-native-nvim ];
              setup = {
                fzf = {
                  fuzzy = true;
                };
              };
            }
          ];
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
        spellcheck = {
          enable = true;
          programmingWordlist.enable = true;
          # Run :DirtytalkUpdate on first use to fix download errors
          extraSpellWords = {
            "en.utf-8" = builtins.filter (s: builtins.isString s) (
              builtins.split "\n" (import ../../data/dictionary/concat.nix)
            );
          };
        };
        keymaps = import ./keymaps/base.nix ++ import ./keymaps/extra.nix { inherit pkgs; };
        extraLuaFiles = [
          ./lua/terminal.lua
          ./lua/clipboard.lua
          ./lua/autocomplete-disable.lua
        ];
      };
    };
  };

}
