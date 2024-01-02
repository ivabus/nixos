{ config, pkgs, lib, ... }:

let
  dotfiles = builtins.fetchGit {
    url = "https://github.com/ivabus/dotfiles";
    rev = "325c752dba65f199348e41ad207c691aae77643e";
  };
  theme = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/ivabus/ivabus-zsh-theme/master/ivabus.zsh-theme";
  };
  highlighting = builtins.fetchGit {
    url = "https://github.com/zsh-users/zsh-syntax-highlighting.git";
    # Just install the latest and don't care about updating
    ref = "master";
  };
in {
  # Option to disable dotfiles for development
  options.my.users.ivabus.dotfiles.enable =
    lib.mkEnableOption "Enable automatic dotfiles installation";
  config.my.users.ivabus.dotfiles.enable = lib.mkDefault true;
  config.home-manager = lib.mkIf
    (config.my.users.ivabus.enable && config.my.users.ivabus.dotfiles.enable) ({
      users.ivabus = {
        home.file = {
          ".config" = {
            source = "${dotfiles}/configs";
            recursive = true;
          };
          ".config/zsh/themes/ivabus.zsh-theme" = { source = theme; };
          ".config/zsh/plugins/zsh-syntax-highlighting/" = {
            source = highlighting;
            recursive = true;
          };
          ".profile" = { source = "${dotfiles}/configs/.profile"; };
          ".zshrc" = { source = "${dotfiles}/configs/.zshrc"; };
        };
      };
    });
}
