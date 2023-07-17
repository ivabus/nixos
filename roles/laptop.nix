{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    powertop
    lm_sensors
  ];
  services.tlp.enable = true;
  services.upower.enable = true;

  networking.wireless.iwd.enable = true;
}