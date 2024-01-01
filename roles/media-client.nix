{ config, pkgs, lib, ... }:

let cfg = config.my.roles.media-client;
in {
  options.my.roles.media-client.enable =
    lib.mkEnableOption "Enable media players, downloaders, etc.";
  config = lib.mkIf (cfg.enable) {
    nixpkgs.overlays = [
      (self: super: {
        mpv = super.wrapMpv (super.mpv.unwrapped.override {
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
        }) { };
      })
    ];
    environment.systemPackages = with pkgs; [ vlc yt-dlp ffmpeg mpv ];

    # Add support for CD/DVD/BD drives
    boot.initrd.availableKernelModules = [ "sr_mod" ];
  };
}
