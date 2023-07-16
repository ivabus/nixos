{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    powertop
  ];
  services.tlp.enable = true;
  services.upower.enable = true;

  networking.wireless.iwd.enable = true;
}