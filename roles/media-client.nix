{ config, pkgs, lib, ... }:

let cfg = config.my.roles.media-client;
in {
  options.my.roles.media-client.enable =
    lib.mkEnableOption "Enable media players, downloaders, etc.";
  config = lib.mkIf (cfg.enable) {
    nixpkgs.overlays = [
      (self: super: {
        mpv = (super.wrapMpv (super.mpv.unwrapped.override {
          cddaSupport = true;
          # No pulse today
          pulseSupport = false;
          pipewireSupport = true;
          screenSaverSupport = false;
          # MATE only
          x11Support = config.my.roles.graphical.basic.enable;
          # Sway only
          waylandSupport = config.my.roles.graphical.enable;
          javascriptSupport = false;
        }) { }).override { scripts = [ self.mpvScripts.mpris ]; };
      })
    ];
    environment.systemPackages = with pkgs; [ vlc yt-dlp ffmpeg mpv ];

    # Setting up only for ivabus user, because user user will use Firefox or anything else to play videos
    home-manager.users.ivabus = lib.mkIf (config.my.users.ivabus.enable) {
      programs.mpv = {
        enable = true;
        config = {
          profile = "gpu-hq";
          ytdl-format = "bestvideo+bestaudio";
          sub-font = "JetBrains Mono";
          sub-scale = "0.6";
        };
      };
    };

    # Add support for CD/DVD/BD drives
    boot.initrd.availableKernelModules = [ "sr_mod" ];
  };
}
