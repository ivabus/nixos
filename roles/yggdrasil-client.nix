{ config, lib, ... }:

let
  cfg = config.my.roles.yggdrasil-client;
in {
  options.my.roles.yggdrasil-client.enable = lib.mkEnableOption "Enable yggdrasil";
  config = lib.mkIf (cfg.enable) {
    services.yggdrasil = {
      enable = true;
      persistentKeys = true;
      settings = {
        Peers = [
          # Maybe add more peers, not only mine
          "tls://ygg.iva.bz:50002"
        ];
      };
    };
  };
}