{ config, pkgs, lib, ... }:

let my = import ../..;
in {
  imports = [ my.modules ];

  networking.hostName = "periculo";

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  # All "my" options
  my.laptop.enable = false;
  my.git.enable = false;
  my.roles = {
    design.enable = false;
    devel.enable = false;
    gaming.enable = false;
    graphical.enable = false;
    latex.enable = false;
    media-client.enable = false;
    torrent.enable = false;
    virtualisation.enable = false;
    yggdrasil-client.enable = false;
    yggdrasil-peer.enable = false;

    server = { ivabus-dev.enable = false; };
  };

  my.users = {
    ivabus.enable = true;
    user.enable = false;
  };

  my.features.secrets = true;

  my.roles.router = {
    enable = false;
    interfaces = {
      wan = "enp1s0";
      lan = "enp2s0";
    };
  };

  # find out interfaces that show onboard
  /* networking = {
       enp1s0.useDHCP = false;
       enp2s0.useDHCP = false;
     };
  */
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "23.05";
}

