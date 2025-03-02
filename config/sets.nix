{ pkgs, ... }:
{
  plugins = {
    auto-save.enable = true;
    # bufferline = {
    #   enable = true;
    #   settings = {
    #     options = {
    #       always_show_bufferline = false;
    #       buffer_close_icon = "";
    #       diagnostics = "nvim_lsp";
    #     };
    #   };
    # };

    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        current_line_blame_opts = {
          virt_text = true;
          virt_text_pos = "eol";
        };
        signcolumn = true;
        signs = {
          add = {
            text = "│";
          };
          change = {
            text = "│";
          };
          changedelete = {
            text = "~";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          untracked = {
            text = "┆";
          };
        };
        watch_gitdir = {
          follow_files = true;
        };
      };
    };

    lazygit.enable = true;
    lualine = {
      enable = true;
      settings.options.globalstatus = true;
    };
    luasnip.enable = true;

    nvim-autopairs.enable = true;
    colorizer.enable = true;
    render-markdown.enable = true;
    todo-comments.enable = true;

    oil = {
      enable = true;
      settings = {
        columns = [
          "icons"
          "permissions"
          "size"
          "mtime"
        ];
        default_file_explorer = true;
        delete_to_trash = true;
        skip_confirmation_for_simple_edits = true;
      };
    };

    treesitter = {
      enable = true;

      folding = false;
      #settings.indent.enable = true;
      settings.highlight.enable = true;
    };

    vim-surround.enable = true;
    web-devicons.enable = true;
    # nav between neovim and zellij
    #zellij-nav.enable = true;
    comment.enable = true;
  };
}
