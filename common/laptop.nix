{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    powertop
    lm_sensors
  ];

  boot.plymouth.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.tlp.enable = true;
  services.upower.enable = true;
}
