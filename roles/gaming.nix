{ config, pkgs, lib, ... }:

let
  cfg = config.my.roles.gaming;
in {
  options.my.roles.gaming.enable = lib.mkEnableOption "Enable wine & steam";
  config = lib.mkIf (cfg.enable) {
    nixpkgs.config.allowUnfree = true;
    hardware.opengl.driSupport32Bit = true;
    services.pipewire.alsa.support32Bit = true;
    programs.steam.enable = true;
    environment.systemPackages = with pkgs; [
      steam
      wineWowPackages.stable
      wine
      (wine.override { wineBuild = "wine64"; })
      wineWowPackages.staging
      winetricks
      wineWowPackages.waylandFull
    ];
  };
}