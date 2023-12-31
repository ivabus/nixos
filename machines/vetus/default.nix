{ config, pkgs, ... }:

let my = import ../..;
in {
  imports = [ ./hardware.nix my.modules ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "vetus";

  my.laptop.enable = false;
  my.git.enable = true;
  my.roles = {
    design.enable = true;
    devel.enable = true;
    gaming.enable = true;
    graphical.enable = true;
    latex.enable = false;
    virtualisation.enable = true;
    yggdrasil-client.enable = true;
    yggdrasil-peer.enable = false;
  };

  my.users = {
    ivabus.enable = true;
    user.enable = false;
  };

  my.features.secrets = true;

  networking.useDHCP = true;

  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  system.stateVersion = "23.05";
}

