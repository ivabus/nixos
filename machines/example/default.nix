
{ config, pkgs, lib, ... }:

let
  my = import ../..;
in {
  imports = [
    ./hardware.nix # Use nixos-generate-config --show-hardware-config > /etc/nixos/machines/MACHINE/hardware.nix
    my.modules
  ];

  # Bootloader configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "MACHINE";

  # All "my" options
  my.laptop.enable = true;
  my.roles = {
    design.enable = true;
    devel.enable = true;
    gaming.enable = true;
    graphical.enable = true;
    latex.enable = true;
    media-client.enable = true;
    torrent.enable = true;
    virtualisation.enable = true;
    yggdrasil-client.enable = true;
  };

  networking.useDHCP = true;

  system.stateVersion = "23.05";
}

