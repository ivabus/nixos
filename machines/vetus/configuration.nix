
{ config, pkgs, ... }:

{

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vetus";
  system.stateVersion = "23.05";
}

