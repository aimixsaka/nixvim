{lib, ...}: {
  config = {
    opts = {
      updatetime = 100; # faster completion
      number = true;
      relativenumber = true;

      autoindent = true;
      autowrite = true;
      confirm = true;
      cursorline = true;
      list = true;
      # show tab as space as usual, trailing space as '-'
      listchars = "tab:  ,trail:-,nbsp:+";
      expandtab = true;
      shiftround = true;
      shiftwidth = 2;
      # showmode = false;
      signcolumn = "yes";
      smartcase = true;
      smartindent = true;
      tabstop = 2;

      ignorecase = true;
      incsearch = true;
      completeopt = "menu,menuone,noselect";
      wildmode = "longest:full,full";

      swapfile = false;
      undofile = true; # Build-in persistent undo
      undolevels = 10000;

      #background = "light";
    };
  };
}
