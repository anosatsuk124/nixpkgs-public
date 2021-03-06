{ config, pkgs, lib, ... }:

let
  npm-global = "$HOME/.npm-global";
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "anosatsuk124";
  home.homeDirectory = "/home/anosatsuk124";

  home.sessionVariables = {
    EDITOR = "nvr -cc split --remote-wait-silent";
    SUDO_EDITOR= "/home/anosatsuk124/.nix-profile/bin/nvim";
    NVIM_LISTEN_ADDRESS = "127.0.0.1:9999";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
    "${npm-global}/bin"
  ];

  imports = [
    ./tmux.nix
    ./neovim.nix
    ./fish.nix
    ./git.nix
    ./direnv.nix
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    file
    htop
    simple-http-server
    bat
    exa
    jq
    nix-prefetch-github
    nodejs-16_x
    pipenv
    zoxide
    ag
    curl
    python3
    neovim-remote
    fzf
    ripgrep
    xsel
    tig
  ];

  home.activation = {
    npmSetPrefix = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD npm set prefix $VERBOSE_ARG ${npm-global}
    '';
  };
}
