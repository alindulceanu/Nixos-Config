[
  {
    mode = "n";
    key = "<leader>ld";
    action = "<cmd>Lspsaga goto_definition<cr>";
    options = {
      desc = "Goto definition of highlighted item";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>lD";
    action = "<cmd>Lspsaga goto_type_definition<cr>";
    options = {
      desc = "Goto type definition of highlighted item";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>lk";
    action = "<cmd>Lspsaga hover_doc<CR>";
    options = {
      desc = "Show docs for hovered item.";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>lc";
    action = "<cmd>Lspsaga code_action<cr>";
    options = {
      desc = "Code Action";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>lff";
    action = "<cmd>Lspsaga finder<cr>";
    options = {
      desc = "Finder";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>lfi";
    action = "<cmd>Lspsaga finder imp<cr>";
    options = {
      desc = "Find Implementation";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>lfI";
    action = "<cmd>Lspsaga incoming_calls<cr>";
    options = {
      desc = "Find Incoming Calls";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>lfo";
    action = "<cmd>Lspsaga outgoing_calls<cr>";
    options = {
      desc = "Find Outgoing Calls";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>lpd";
    action = "<cmd>Lspsaga peek_definition<cr>";
    options = {
      desc = "Peek Definition";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>lpt";
    action = "<cmd>Lspsaga peek_type_definition<cr>";
    options = {
      desc = "Peek Type Definition";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>\\";
    action = "<cmd>Oil<cr>";
    options = {
      desc = "Jump to Oil";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>ff";
    action = "<cmd>Telescope find_files<cr>";
    options = {
      desc = "Find files";
      silent = false;
    };
  }
  {
    mode = "n";
    key = "<leader>fg";
    action = "<cmd>Telescope live_grep<cr>";
    options = {
      desc = "Live grep";
      silent = false;
    };
  }
  {
    mode = "n";
    key = "<leader>fb";
    action = "<cmd>Telescope buffers<cr>";
    options = {
      desc = "List open buffers";
      silent = false;
    };
  }
  {
    mode = "n";
    key = "<leader>fh";
    action = "<cmd>Telescope help_tags<cr>";
    options = {
      desc = "Search help tags";
      silent = false;
    };
  }
  {
    mode = "n";
    key = "<leader>fc";
    action = "<cmd>Telescope commands<cr>";
    options = {
      desc = "List commands";
      silent = false;
    };
  }
  {
    mode = "n";
    key = "<leader>ft";
    action = "<cmd>Telescope treesitter<cr>";
    options = {
      desc = "Search Treesitter symbols";
      silent = false;
    };
  }
  {
    mode = "n";
    key = "<leader>fs";
    action = "<cmd>Telescope lsp_document_symbol<cr>";
    options = {
      desc = "LSP document symbols";
      silent = false;
    };
  }
  {
    mode = "n";
    key = "<leader>fr";
    action = "<cmd>Telescope oldfiles<cr>";
    options = {
      desc = "Recent files";
      silent = false;
    };
  }
  {
    mode = "n";
    key = "<leader>fd";
    action = "<cmd>Telescope diagnostics<cr>";
    options = {
      desc = "Diagnostics";
      silent = false;
    };
  }
  {
    mode = "n";
    key = "<C-h>";
    action = "<C-w>h";
    options.desc = "Move to left window";
  }
  {
    mode = "n";
    key = "<C-j>";
    action = "<C-w>j";
    options.desc = "Move to window below";
  }
  {
    mode = "n";
    key = "<C-k>";
    action = "<C-w>k";
    options.desc = "Move to window above";
  }
  {
    mode = "n";
    key = "<C-l>";
    action = "<C-w>l";
    options.desc = "Move to right window";
  }
  {
    mode = "n";
    key = "<leader>wo";
    action = "<C-w>o";
    options.desc = "Close all other windows";
  }
  {
    mode = "n";
    key = "<leader>w=";
    action = "<C-w>=";
    options.desc = "Equalize split sizes";
  }
  {
    mode = "n";
    key = "<C-Up>";
    action = "<cmd>resize -2<CR>";
    options = {
      desc = "Resize window height up";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<C-Down>";
    action = "<cmd>resize +2<CR>";
    options = {
      desc = "Resize window height down";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<C-Left>";
    action = "<cmd>vertical resize -2<CR>";
    options = {
      desc = "Resize window width left";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<C-Right>";
    action = "<cmd>vertical resize +2<CR>";
    options = {
      desc = "Resize window width right";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>cp";
    action = "<cmd>CccPick<CR>";
    options = {
      desc = "Pick a color";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>cc";
    action = "<cmd>CccConvert<CR>";
    options = {
      desc = "Convert color under cursor";
      silent = true;
    };
  }
  {
    mode = "n";
    key = "<leader>cf";
    action = "<cmd>CccHighlighterToggle<CR>";
    options = {
      desc = "Toggle color highlighter";
      silent = true;
    };
  }
]
