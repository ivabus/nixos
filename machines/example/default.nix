{ config, pkgs, lib, ... }:

let my = import ../..;
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
  my.git.enable = true;
  my.roles = {
    design.enable = true;
    devel.enable = true;
    gaming.enable = true;
    graphical.enable = true;
    graphical.basic.enable = false;
    latex.enable = true;
    media-client.enable = true;
    torrent.enable = true;
    virtualisation.enable = true;
    yggdrasil-client.enable = true;

    server = { ivabus-dev.enable = true; };
  };
  my.users = {
    ivabus.enable = true;
    user.enable = false;
  };
  my.features.secrets = true;

  networking.useDHCP = true;

  system.stateVersion = "23.05";
}

