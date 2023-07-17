{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
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