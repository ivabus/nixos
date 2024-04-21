{ config, lib, pkgs, ... }:
let cfg = config.my.roles.server.slides-ivabus-dev;
in {
  options.my.roles.server.slides-ivabus-dev.enable =
    lib.mkEnableOption "Serve slides.ivabus.dev";
  config = lib.mkIf (cfg.enable) {
    my.roles.server.nginx.enable = true;
    services.nginx = {
      virtualHosts."slides.ivabus.dev" = {
        forceSSL = true;
        enableACME = true;
        quic = true;
        http3 = true;

        root = pkgs.callPackage ../../pkgs/slides-ivabus-dev.nix { };

        extraConfig = ''
          error_page 404 /404.html;
        '';
      };
    };
  };
}
