{ config, lib, pkgs, ... }:
let cfg = config.my.roles.server.ivabus-dev;
in {
  options.my.roles.server.ivabus-dev.enable =
    lib.mkEnableOption "Serve ivabus.dev";
  config = lib.mkIf (cfg.enable) {
    my.roles.server.nginx.enable = true;
    services.nginx = {
      virtualHosts."ivabus.dev" = {
        forceSSL = true;
        enableACME = true;
        quic = true;
        http3 = true;

        root = pkgs.callPackage ../../pkgs/ivabus-dev.nix { };

        extraConfig = ''
          error_page 404 /404.html;
          add_header Access-Control-Allow-Origin *;
        '';
        serverAliases = [ "www.ivabus.dev" ];
      };
    };
  };
}
