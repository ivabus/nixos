{ config, lib, secrets, ... }:

let cfg = config.my.roles.yggdrasil-client;
in {
  options.my.roles.yggdrasil-client.enable =
    lib.mkEnableOption "Enable yggdrasil";
  config = lib.mkIf (cfg.enable) {
    my.features.secrets = lib.mkForce true;
    services.yggdrasil = {
      enable = true;
      persistentKeys = true;
      settings = {
        # Not connecting to global ygg network
        Peers = lib.mkDefault [
          "quic://${secrets.yggdrasil-peer}:60003?password=${secrets.yggdrasil-password}"
          "tls://${secrets.yggdrasil-peer}:60002?password=${secrets.yggdrasil-password}"
        ];
      };
    };
  };
}
