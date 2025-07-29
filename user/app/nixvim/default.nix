{ inputs, pkgs, ... }:
let
  keymaps = import ./keymaps.nix;
in
{
  imports = [ inputs.nixvim.homeModules.nixvim ];
  programs.nixvim = {
    enable = true;
    colorschemes.tokyonight.enable = true;

    globals = {
      mapleader = " ";
      localleader = ",";
    };

    keymaps = keymaps;
    opts = {
      relativenumber = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      smartindent = true;
      signcolumn = "yes";
      # guifont = "${config.stylix.fonts.monospace.name}:h12";
    };

    plugins = {
      lualine.enable = true;
      nvim-surround.enable = true;
      auto-session.enable = true;
      comment.enable = true;
      illuminate.enable = true;
      trouble.enable = true;
      smear-cursor.enable = true;
      auto-save.enable = true;
      modicator.enable = true;
      transparent.enable = true;
      guess-indent.enable = true;
      indent-blankline.enable = true;
      git-conflict.enable = true;
      oil-git-status.enable = true;
      indent-tools.enable = true;
      which-key.enable = true;
      lspsaga.enable = true;
      dap.enable = true;
      dap-python.enable = true;
      dap-ui.enable = true;
      dap-virtual-text.enable = true;
      dap-lldb.enable = true;
      none-ls = {
        enable = true;

        sources.formatting = {
          prettier = { };
          stylua = { };
          black = { };
          clang_format = { };
          shfmt = { };
        };
      };

      telescope = { 
        enable = true;

        extensions = {
          file-browser.enable = true;
          fzy-native.enable = true;
          ui-select.enable = true;
        };
      };
      
      nvim-autopairs = {
        enable = true;
        settings = {
          check_ts = true;  # Enables Treesitter integration for smarter pairing
        };
      };

      toggleterm = {
        enable = true;
        settings = {
          direction = "horizontal";
          open_mapping = "[[<c-\\>]]";
          size = 50;
        };
      };

      ccc.enable = true;

      cmp = {
        enable = true;
        autoEnableSources = true;
        
        settings = {
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-n>" = "cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }";
            "<C-u>" = "cmp.mapping.complete({})";
            "<C-p>" = "cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }";
            "<C-y>" = ''
              cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }, {"i", "c"})'';
            "<C-space>" = ''
              cmp.mapping {
                i = cmp.mapping.complete(),
                c = function(
                  _ --[[fallback]]
                  )
                  if cmp.visible() then
                  if not cmp.confirm { select = true } then
                  return
                  end
                  else
                  cmp.complete()
                  end
                  end,
                }
            '';
            "<tab>" = "cmp.config.disable";
          };

          snippet = {
            expand = ''
              function(args)
              require("luasnip").lsp_expand(args.body)
              end
            '';
          };

          sources = [
            { name = "nvim_lsp"; }
            {
              name = "luasnip";
              option = { show_autosnippets = true; };
            }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
        };

      oil = {
        enable = true;

        settings = {
          delete_to_trash = true;
          skip_confirm_for_single_edits = true;

          use_default_keymaps = false;
          
          keymaps = {
            "g?" = "actions.show_help";
            "<CR>" = "actions.select";
            "-" = "actions.parent";
            "_" = "actions.open_cwd";
            "`" = "actions.cd";
            "~" = "actions.tcd";
            "g." = "actions.toggle_hidden";
          };
        };
      };

      lsp = { 
        enable = true;
        servers = {
          nil_ls.enable = true;
          bashls.enable = true;
          ts_ls.enable = true;
          pyright.enable = true;
          rust_analyzer = {
            installCargo = false;
            installRustc = false;
          };
        };
      };

      web-devicons.enable = true;
      treesitter = {
        enable = true;

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          java
          kotlin
          rust
          go
          nix
          regex
          json
          xml
          yaml
          typescript
          javascript
          python
          cpp
        ];

        settings = {
          textobjects.enable = true;

          highlight = {
            enable = true;
            disable = ''
              function(lang, bufnr)
              return vim.api.nvim_buf_line_count(bufnr) > 10000
              end
            '';
            
            incremental_selection = { enable = true; };

            indent = { enable = false; };
          };
        };
      };
      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 4;
        };
      };
    };

  };
}
