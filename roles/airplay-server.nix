{ config, pkgs, lib, ... }:

let cfg = config.my.roles.airplay-server;
in {
  options.my.roles.airplay-server.enable =
    lib.mkEnableOption "Enable uxplay and open ports";
  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [ uxplay ];
    networking.firewall.allowedUDPPorts = [ 6000 6001 7011 ];
    networking.firewall.allowedTCPPorts = [ 7000 7001 7100 ];
  };
}
