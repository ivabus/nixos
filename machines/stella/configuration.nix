
{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "stella";

  services.xserver.videoDrivers=["amdgpu"];
  boot.initrd.kernelModules=["amdgpu"];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  system.stateVersion = "23.05";
}

