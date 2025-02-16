{
  config = {
    opts = {
      updatetime = 100; # faster completion

      filetype.syntax = "on";

      number = true;
      relativenumber = true;

      autoindent = true;
      # show tab as '>', trailing space as '-'
      list = true;
      shiftround = true;
      smartcase = true;
      smartindent = true;

      ignorecase = true;
      incsearch = true;
      completeopt = "menu,menuone,noselect";
      wildmode = "longest:full,full";

      swapfile = false;
      undofile = true; # Build-in persistent undo
      undolevels = 10000;
    };
  };
}
