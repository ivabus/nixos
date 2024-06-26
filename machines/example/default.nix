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
  my.laptop.enable = false;
  my.git.enable = false;
  my.roles = {
    design.enable = false;
    devel.enable = false;
    gaming.enable = false;
    graphical.enable = false;
    graphical.basic.enable = false;
    latex.enable = false;
    media-client.enable = false;
    torrent.enable = false;
    virtualisation.enable = false;
    yggdrasil-client.enable = true;

    server = {
      ivabus-dev.enable = false;
      slides-ivabus-dev.enable = false;
      urouter.enable = false;
    };
  };
  my.users = {
    ivabus.enable = true;
    ivabus.dotfiles.enable = true;
    user.enable = false;
  };
  my.features.secrets = true;

  networking.useDHCP = true;

  system.stateVersion = "23.05";
}

