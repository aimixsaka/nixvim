{pkgs, ...}: {
  extraPlugins = with pkgs; [
    vimPlugins.vim-dadbod # DB client
    vimPlugins.vim-dadbod-completion # DB completion
    vimPlugins.vim-dadbod-ui # DB UI
  ];

  extraConfigLua = ''
    require("telescope").load_extension('harpoon')

    require("notify").setup({
      background_colour = "#000000",
    })
  '';
}
