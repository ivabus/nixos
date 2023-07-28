
{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "stella";

  services.xserver.videoDrivers=["amdgpu"];
  boot.initrd.kernelModules=["amdgpu"];

  system.stateVersion = "23.05";
}

