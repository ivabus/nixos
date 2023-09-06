{ config, lib, pkgs, ... }:
let
  cfg = config.my.roles.server.nginx;
in
{
  # Don't call from machine setup, services will enable it automatically
	options.my.roles.server.nginx.enable = lib.mkEnableOption "Initial nginx setup";
  config = lib.mkIf (cfg.enable) {
    services.nginx = {
      enable = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
    };
  };
}