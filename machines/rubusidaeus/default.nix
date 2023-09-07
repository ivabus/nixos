{ config, pkgs, lib, ... }:

let my = import ../..;
in {
  imports = [ my.modules ../../hardware/rpi4.nix ];

  networking.hostName = "rubusidaeus";

  my.laptop.enable = false;
  my.git.enable = false;
  my.roles = {
    design.enable = false;
    devel.enable = false;
    gaming.enable = false;
    graphical.enable = false;
    latex.enable = false;
    media-client.enable = false;
    ntp-server.enable = false;
    torrent.enable = false;
    virtualisation.enable = false;
    yggdrasil-client.enable = true;

    server = { ivabus-dev.enable = true; };
  };

  networking.useDHCP = true;

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.05";
}

