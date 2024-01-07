{ config, pkgs, lib, ... }:

let
  dotfiles = builtins.fetchGit {
    url = "https://github.com/ivabus/dotfiles";
    rev = "8c7bae390d11c9aa16aec85a33124b791dbab4ac";
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
  config.home-manager.users.ivabus = lib.mkIf
    (config.my.users.ivabus.enable && config.my.users.ivabus.dotfiles.enable)
    (lib.mkMerge [
      {
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
      }
      (lib.mkIf config.my.roles.graphical.enable {
        # NixOS only things
        programs.firefox = {
          enable = true;
          profiles.default = {
            id = 0;
            name = "default";
            isDefault = true;
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              stylus
            ];
            search = {
              force = true;
              engines = {
                "Nix Packages" = {
                  urls = [{
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }];
                  icon =
                    "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "@np" ];
                };
                "NixOS Wiki" = {
                  urls = [{
                    template =
                      "https://nixos.wiki/index.php?search={searchTerms}";
                  }];
                  icon =
                    "''${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                  definedAliases = [ "@nw" ];
                };
              };
            };
            userChrome = ''
              .titlebar-buttonbox-container, .titlebar-spacer, #alltabs-button {
                display:none;
              }'';
            bookmarks = [
              {
                name = "NixOS Search";
                url = "https://search.nixos.org";
              }
              {
                name = "GitHub";
                url = "https://github.com";
              }
              {
                name = "YouTube";
                url = "https://youtube.com";
              }
              {
                name = "VK";
                url = "https://vk.com";
              }
              {
                name = "Mastodon";
                url = "https://social.treehouse.systems";
              }
              # I go to school, you know?
              {
                name = "ЭД";
                url = "https://dnevnik2.petersburgedu.ru";
              }
            ];
            settings = {
              "intl.accept_languages" = [ "ru-RU" "ru" "en-US" "en" ];
              "font.language.group" = "x-cyrillic";
            };
          };
        };
      })
    ]);
}
