{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    powertop
    lm_sensors
  ];

  boot.plymouth.enable = true;
  
  services.tlp.enable = true;
  services.upower.enable = true;
}