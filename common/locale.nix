{ config, pkgs, ... }:

{
  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "ru_RU.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u24b.psf.gz";
    keyMap = "us";
    packages = with pkgs; [ terminus_font ];
  };
}