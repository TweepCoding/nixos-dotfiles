{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom;
let
  cfg = config.apps.nvim;
in
{
  imports = [
    inputs.nixvim.nixosModules.nixvim

    ./plugins/gitsigns.nix
    ./plugins/which-key.nix
    ./plugins/telescope.nix
    ./plugins/conform.nix
    ./plugins/lsp.nix
    ./plugins/nvim-cmp.nix
    ./plugins/mini.nix
    ./plugins/treesitter.nix

    ./plugins/kickstart/plugins/debug.nix
    ./plugins/kickstart/plugins/indent-blankline.nix
    ./plugins/kickstart/plugins/lint.nix
    ./plugins/kickstart/plugins/autopairs.nix

    ./plugins/custom/plugins/oil.nix
    ./plugins/custom/plugins/transparent.nix
    ./plugins/custom/plugins/typescript_tools.nix
    ./plugins/custom/plugins/tailwind_tools.nix
    ./plugins/custom/plugins/flutter_tools.nix
    ./plugins/custom/plugins/none_ls.nix
  ];

  options.apps.nvim = with types; {
    enable = mkBoolOpt true "Enable neovim/nixvim";
  };

  config = mkIf cfg.enable {

    programs.nixvim = {
      enable = true;
      defaultEditor = true;

      colorschemes = {
        # https://nix-community.github.io/nixvim/colorschemes/tokyonight/index.html
        catppuccin = {
          enable = true;
        };
      };

      # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=globals#globals
      globals = {
        mapleader = " ";
        maplocalleader = " ";
        have_nerd_font = true;
      };

      opts = {
        number = true;
        relativenumber = true;
        mouse = "a";
        showmode = false;
        clipboard = {
          providers = {
            wl-copy.enable = true; # For Wayland
          };
          # Sync clipboard between OS and Neovim
          #  Remove this option if you want your OS clipboard to remain independent.
          register = "unnamedplus";
        };

        # Enable break indent
        breakindent = true;

        # Save undo history
        undofile = true;

        # Case-insensitive searching UNLESS \C or one or more capital letters in search term
        ignorecase = true;
        smartcase = true;

        # Keep signcolumn on by default
        signcolumn = "yes";

        # Decrease update time
        updatetime = 250;

        # Decrease mapped sequence wait time
        # Displays which-key popup sooner
        timeoutlen = 300;

        # Configure how new splits should be opened
        splitright = true;
        splitbelow = true;

        # Sets how neovim will display certain whitespace characters in the editor
        #  See `:help 'list'`
        #  See `:help 'listchars'`
        list = true;
        # NOTE: .__raw here means that this field is raw lua code
        listchars.__raw = "{ tab = '» ', trail = '·', nbsp = '␣' }";

        # Preview subsitutions live, as you type!
        inccommand = "split";

        # Show which line your cursor is on
        cursorline = true;

        # Minimal number of screen lines to keep above and below the cursor
        scrolloff = 10;

        # See `:help hlsearch`
        hlsearch = true;
      };

      # [[ Basic Keymaps ]]
      #  See `:help vim.keymap.set()`
      # https://nix-community.github.io/nixvim/keymaps/index.html
      keymaps = [
        # Clear highlights on search when pressing <Esc> in normal mode
        {
          mode = "n";
          key = "<Esc>";
          action = "<cmd>nohlsearch<CR>";
        }
        # Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
        # for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
        # is not what someone will guess without a bit more experience.
        #
        # NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
        # or just use <C-\><C-n> to exit terminal mode
        {
          mode = "t";
          key = "<Esc><Esc>";
          action = "<C-\\><C-n>";
          options = {
            desc = "Exit terminal mode";
          };
        }
        # TIP: Disable arrow keys in normal mode
        {
          mode = "n";
          key = "<left>";
          action = "<cmd>echo 'Use h to move!!'<CR>";
        }
        {
          mode = "n";
          key = "<right>";
          action = "<cmd>echo 'Use l to move!!'<CR>";
        }
        {
          mode = "n";
          key = "<up>";
          action = "<cmd>echo 'Use k to move!!'<CR>";
        }
        {
          mode = "n";
          key = "<down>";
          action = "<cmd>echo 'Use j to move!!'<CR>";
        }
        # Keybinds to make split navigation easier.
        #  Use CTRL+<hjkl> to switch between windows
        #
        #  See `:help wincmd` for a list of all window commands
        {
          mode = "n";
          key = "<C-h>";
          action = "<C-w><C-h>";
          options = {
            desc = "Move focus to the left window";
          };
        }
        {
          mode = "n";
          key = "<C-l>";
          action = "<C-w><C-l>";
          options = {
            desc = "Move focus to the right window";
          };
        }
        {
          mode = "n";
          key = "<C-j>";
          action = "<C-w><C-j>";
          options = {
            desc = "Move focus to the lower window";
          };
        }
        {
          mode = "n";
          key = "<C-k>";
          action = "<C-w><C-k>";
          options = {
            desc = "Move focus to the upper window";
          };
        }
      ];

      # https://nix-community.github.io/nixvim/NeovimOptions/autoGroups/index.html
      autoGroups = {
        kickstart-highlight-yank = {
          clear = true;
        };
      };

      # [[ Basic Autocommands ]]
      #  See `:help lua-guide-autocommands`
      # https://nix-community.github.io/nixvim/NeovimOptions/autoCmd/index.html
      autoCmd = [
        # Highlight when yanking (copying) text
        #  Try it with `yap` in normal mode
        #  See `:help vim.highlight.on_yank()`
        {
          event = [ "TextYankPost" ];
          desc = "Highlight when yanking (copying) text";
          group = "kickstart-highlight-yank";
          callback.__raw = ''
            function()
              vim.highlight.on_yank()
            end
          '';
        }
      ];

      plugins = {
        # Adds icons for plugins to utilize in ui
        web-devicons.enable = true;

        # Detect tabstop and shiftwidth automatically
        # https://nix-community.github.io/nixvim/plugins/sleuth/index.html
        sleuth = {
          enable = true;
        };

        # Highlight todo, notes, etc in comments
        # https://nix-community.github.io/nixvim/plugins/todo-comments/index.html
        todo-comments = {
          settings = {
            enable = true;
            signs = true;
          };
        };
      };

      # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraplugins
      extraPlugins = with pkgs.vimPlugins; [
        # Useful for getting pretty icons, but requires a Nerd Font.
        nvim-web-devicons # TODO: Figure out how to configure using this with telescope
      ];

      # TODO: Figure out where to move this
      # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapre
      extraConfigLuaPre = ''
        if vim.g.have_nerd_font then
          require('nvim-web-devicons').setup {}
        end
      '';

      # The line beneath this is called `modeline`. See `:help modeline`
      # https://nix-community.github.io/nixvim/NeovimOptions/index.html?highlight=extraplugins#extraconfigluapost
      extraConfigLuaPost = ''
        -- vim: ts=2 sts=2 sw=2 et
      '';
    };

  };
}
