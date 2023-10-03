{ config, pkgs, lib, ... }:

let cfg = config.my.laptop;
in {
  options = {
    my.laptop.enable = lib.mkEnableOption "Laptop-specific configuration";
  };

  config = lib.mkIf (cfg.enable) {
    networking.wireless.iwd.enable = lib.mkDefault true;
    environment.systemPackages = with pkgs; [ lm_sensors ];

    hardware.bluetooth.enable = lib.mkDefault true;
    services.blueman.enable = lib.mkDefault true;

    services.tlp.enable = lib.mkDefault true;
    services.upower.enable = lib.mkDefault true;
  };
}
