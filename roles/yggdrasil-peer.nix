{ config, lib, secrets, ... }:

let cfg = config.my.roles.yggdrasil-peer;
in {
  options.my.roles.yggdrasil-peer.enable =
    lib.mkEnableOption "Enable yggdrasil (semi-public) peer";
  config = lib.mkIf (cfg.enable) {
    my.features.secrets = lib.mkForce true;
	my.roles.yggdrasil-client.enable = true;
    services.yggdrasil = {
      enable = true;
      persistentKeys = true;
      settings = 
      {
        # Not connecting to global ygg network
        Peers = lib.mkForce [];
		Listen = [
          "quic://[::]:60003?password=${secrets.yggdrasil-password}"
          "tls://[::]:60002?password=${secrets.yggdrasil-password}"
		];
      };
    };
    networking.firewall.allowedTCPPorts = [ 60002 ];
    networking.firewall.allowedUDPPorts = [ 60003 ];
  };
}
