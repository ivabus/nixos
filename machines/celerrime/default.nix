{ config, pkgs, ... }:

let
  my = import ../..;
in {
  imports = [
    ./hardware.nix
    my.modules
  ];
  
  networking.hostName = "celerrime";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  # Enable screen space near notch
  boot.kernelParams = [ "apple_dcp.show_notch=1" ];

  my.laptop.enable = true;
  my.roles = {
    design.enable = true;
    devel.enable = true;
    gaming.enable = false;
    graphical.enable = true;
    latex.enable = true;
    virtualisation.enable = false;
    yggdrasil-client.enable = true;
  };

  # Setup asahi-specific things. NOTE: you must copy firmware from ESP to /etc/nixos/asahi/firmware
  hardware.asahi.peripheralFirmwareDirectory = ../../asahi/firmware;
  hardware.asahi.addEdgeKernelConfig = true;
  hardware.asahi.useExperimentalGPUDriver = true;

  system.stateVersion = "23.05";
}
