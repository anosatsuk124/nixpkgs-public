{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      tree = "ls -T";
      ll = "exa -al --icons";
      ls = "exa --icons";
      la = "exa -lag";
    };
    interactiveShellInit = ''
      # key bindings
      function fish_user_key_bindings
        fish_vi_key_bindings
        bind -M insert -m default jj backward-char force-repaint
      end

			set fish_color_command white

			# Set the env for fzf
			set -gx FZF_DEFAULT_OPTS '--height 40% --reverse --border'
			set -gx FZF_DEFAULT_COMMAND 'ag -a --ignore .git -g ""'

			zoxide init fish | source
    '';
    plugins = [
      {
        name = "bass";
        src = pkgs.fetchFromGitHub {
          owner = "edc";
          repo = "bass";
          rev = "v1.0";
          sha256 = "XpB8u2CcX7jkd+FT3AYJtGwBtmNcLXtfMyT/z7gfyQw=";
        };
      }
      {
        name = "fzf";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "fzf";
          rev = "master";
          sha256 = "28QW/WTLckR4lEfHv6dSotwkAKpNJFCShxmKFGQQ1Ew=";
        };
      }
      {
        name = "theme-lambda";
        src = pkgs.fetchFromGitHub {
          owner = "hasanozgan";
          repo = "theme-lambda";
          sha256 = "ZoyQfwqeQUFOP49Ebyel7TQUzEwD+HreZNFFYo/ICKs=";
          rev = "master";
        };
      }
    ];
  };
}
