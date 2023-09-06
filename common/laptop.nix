{ config, pkgs, lib, ... }:

let cfg = config.my.laptop;
in {
  options = {
    my.laptop.enable = lib.mkEnableOption "Laptop-specific configuration";
  };

  config = lib.mkIf (cfg.enable) {
    networking.wireless.iwd.enable = true;
    environment.systemPackages = with pkgs; [ lm_sensors ];

    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    services.tlp.enable = true;
    services.upower.enable = true;
  };
}
