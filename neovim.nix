{pkgs, ...}:
let
  lucario-theme = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "lucario-theme";
    version = "2021-12-08";
    src = pkgs.fetchFromGitHub {
      owner = "raphamorim";
      repo = "lucario";
      sha256 = "POIFjtMHldF3ZRLGBxzx2hJ84q3TH6ZTwsyPZA53sYQ=";
      rev = "master";
    };
  };
  eskk-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "eskk.vim";
    version = "2021-12-08";
    src = pkgs.fetchFromGitHub {
      owner = "tyru";
      repo = "eskk.vim";
      sha256 = "0m1EjMrq4cJ54ARUIfuP/OJp5D6GT4rUAg2eXXjZyNA=";
      rev = "master";
    };
  };
in
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = [
      pkgs.vimPlugins.coc-nvim
      pkgs.vimPlugins.auto-pairs
      pkgs.vimPlugins.vim-polyglot
      pkgs.vimPlugins.defx-nvim
      pkgs.vimPlugins.nvim-treesitter
      pkgs.vimPlugins.fzf-vim
      lucario-theme
      eskk-vim
    ];
    extraConfig = ''
      ${builtins.readFile ./nvim/init.vim}
      ${builtins.readFile ./nvim/plugins.conf/coc.vim}
      ${builtins.readFile ./nvim/plugins.conf/colorscheme.vim}
      ${builtins.readFile ./nvim/plugins.conf/defx.vim}
      ${builtins.readFile ./nvim/plugins.conf/nvim-treesitter.vim}
      ${builtins.readFile ./nvim/plugins.conf/fzf.vim}
      ${builtins.readFile ./nvim/plugins.conf/eskk.vim}
    '';
  };
  xdg.configFile."nvim/coc-settings.json".text = ''
    {
      "suggest.enablePreselect": false,
      "suggest.noselect": true,
      "coc.preferences.formatOnSaveFiletypes": ["css", "markdown"],
      "languageserver": {
        "purescript": {
         "command": "purescript-language-server",
          "args": ["--stdio"],
          "filetypes": ["purescript"],
          "trace.server": "off",
          "rootPatterns": ["bower.json", "psc-package.json", "spago.dhall"],
          "settings": {
            "purescript": {
              "addSpagoSources": true,
              "addNpmPath": true // Set to true if using a local purty install for formatting
              // etc
            }
          }
        },
        "bash": {
          "command": "bash-language-server",
          "args": [
            "start"
          ],
          "filetypes": [
            "sh"
          ],
          "ignoredRootPaths": [
            "~"
          ]
        }
      }
    }
  '';
}
