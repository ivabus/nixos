{ config, pkgs, lib, ... }:

let cfg = config.my.roles.media-client;
in {
  options.my.roles.media-client.enable =
    lib.mkEnableOption "Enable media players, downloaders, etc.";
  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [ vlc yt-dlp ffmpeg ];
  };
}
