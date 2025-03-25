[
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
    action = "<C-\\><C-n><cmd>w<cr>";
    desc = "save current buffer ( same as `:w`)";
  }
  {
    key = "<leader>fi";
    mode = "n";
    action = ":let @+ = expand('%:.') . ':' . line('.')<cr>";
    desc = "copy relative file path with line number";
  }
  {
    key = "<leader>fI";
    mode = "n";
    action = ":let @+ = expand('%:p') . ':' . line('.')<cr>";
    desc = "copy absolute file path with line number";
  }
  {
    key = "<leader>fwv";
    mode = "n";
    action = "<C-w>o<C-w>v<cmd>execute \"edit \" . getreg(\"+\")<cr>";
    desc = "split vertically between the current buffer and the clipboard buffer";
  }
  {
    key = "<leader>fws";
    mode = "n";
    action = "<C-w>o<C-w>s<cmd>execute \"edit \" . getreg(\"+\")<cr>";
    desc = "split horizontally between the current buffer and the clipboard buffer";
  }

]
