{ config, pkgs, lib, ... }:

let
  cfg = config.my.roles.ntp-server;
in {
  options.my.roles.ntp-server.enable = lib.mkEnableOption "Enable NTP server";
  config = lib.mkIf (cfg.enable) {
	services.chrony.extraConfig = ''
allow 192.168.0.0/16
	'';
    networking.firewall.allowedUDPPorts = [ 123 ];
  };
}
