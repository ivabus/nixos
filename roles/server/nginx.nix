{ config, lib, pkgs, ... }:
let cfg = config.my.roles.server.nginx;
in {
  # Don't call from machine setup, services will enable it automatically
  options.my.roles.server.nginx.enable =
    lib.mkEnableOption "Initial nginx setup";
  config = lib.mkIf (cfg.enable) {
    services.nginx = {
      enable = true;
      package = pkgs.nginxQuic;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
    };

    security.acme = {
      acceptTerms = true;
      defaults.email = "ivabus@ivabus.dev";
    };
    networking.firewall.allowedTCPPorts = [ 80 443 ];
    networking.firewall.allowedUDPPorts = [ 80 443 ];
  };
}
