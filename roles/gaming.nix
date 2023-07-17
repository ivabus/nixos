{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  hardware.opengl.driSupport32Bit = true;
  services.pipewire.alsa.support32Bit = true;
  environment.systemPackages = with pkgs; [
    steam
    wineWowPackages.stable
    wine
    (wine.override { wineBuild = "wine64"; })
    wineWowPackages.staging
    winetricks
    wineWowPackages.waylandFull
  ];
}