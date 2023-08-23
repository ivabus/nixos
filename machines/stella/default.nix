
{ config, pkgs, lib, ... }:

let
  my = import ../..;
in {
  imports = [
    ./hardware.nix
    my.modules
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "stella";

  my.laptop.enable = true;
  my.roles = {
    design.enable = true;
    devel.enable = true;
    gaming.enable = true;
    graphical.enable = true;
    latex.enable = true;
    virtualisation.enable = true;
    yggdrasil-client.enable = true;
  };

  services.xserver.videoDrivers=["amdgpu"];
  boot.initrd.kernelModules=["amdgpu"];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "ondemand";
  };

  system.stateVersion = "23.05";
}

