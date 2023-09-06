{ config, pkgs, lib, ... }:

let cfg = config.my.roles.gaming;
in {
  options.my.roles.gaming.enable = lib.mkEnableOption "Enable wine & steam";
  config = lib.mkIf (cfg.enable) (lib.mkMerge [
    {
      nixpkgs.config.allowUnfree = true;
      hardware.opengl.driSupport32Bit = true;
      services.pipewire.alsa.support32Bit = true;
      environment.systemPackages = with pkgs; [
        wineWowPackages.stable
        wine
        (wine.override { wineBuild = "wine64"; })
        wineWowPackages.staging
        winetricks
        wineWowPackages.waylandFull
        (retroarch.override { cores = with libretro; [ np2kai ]; })
      ];
    }
    # Enable steam only on x86_64 (since I have hosts with ARM, but I don't think I will enable my.roles.gaming on ARM system soon)
    (lib.mkIf (pkgs.stdenv.isx86_64) {
      programs.steam.enable =
        true; # Firewall ports used by Steam in-home streaming.
      networking.firewall.allowedTCPPorts = [ 27036 27037 ];
      networking.firewall.allowedUDPPorts = [ 27031 27036 ];
    })
  ]);
}
