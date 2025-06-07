{pkgs, ...}: {
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
          java.enable = true;
          markdown.enable = true;
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
        spellcheck = {
          enable = true;
          programmingWordlist.enable = true;
          extraSpellWords = {
            "en.utf-8" = builtins.filter (s: builtins.isString s) (
              builtins.split "\n" (
                builtins.readFile ./dictionary/base.txt + "\n" + builtins.readFile ./dictionary/extra.txt
              )
            );
          };
        };
        keymaps = import ./keymaps/base.nix ++ import ./keymaps/extra.nix {inherit pkgs;};
        extraLuaFiles = [./lua/terminal.lua ./lua/clipboard.lua];
      };
    };
  };
}
