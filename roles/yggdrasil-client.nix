{ ... }:

{
  services.yggdrasil = {
    enable = true;
    persistentKeys = true;
    settings = {
      Peers = [
        "tls://ygg.iva.bz:50002"
      ];
    };
  };
}