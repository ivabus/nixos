{ config, pkgs, ... }:

{
  imports = [  ];
  networking.hostName = "celerrime";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelParams = [ "apple_dcp.show_notch=1" ];

  hardware.asahi.peripheralFirmwareDirectory = ../../asahi/firmware;
  hardware.asahi.addEdgeKernelConfig = true;
  hardware.asahi.useExperimentalGPUDriver = true;

  system.stateVersion = "23.05";
}
