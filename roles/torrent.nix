{ config, pkgs, lib, ... }:

let cfg = config.my.roles.torrent;
in {
  options.my.roles.torrent.enable =
    lib.mkEnableOption "Enable torrent support.";
  # TODO: do something about systems without GUI (i don't use any at the moment)
  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = with pkgs;
      [ (transmission.override { enableGTK3 = true; }) ];
  };
}
