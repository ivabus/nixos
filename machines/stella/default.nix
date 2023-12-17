{ config, pkgs, lib, ... }:

let my = import ../..;
in {
  imports = [ ./hardware.nix my.modules ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    google-chrome
    zoom-us
    whatsapp-for-linux
    telegram-desktop
  ];

  networking.hostName = "stella";

  my.laptop.enable = true;
  my.git.enable = true;
  my.roles = {
    design.enable = false;
    devel.enable = false;
    gaming.enable = false;
    graphical.enable = false;
    graphical.basic.enable = true;
    latex.enable = false;
    media-client.enable = true;
    torrent.enable = false;
    virtualisation.enable = false;
    yggdrasil-client.enable = true;
    yggdrasil-peer.enable = false;
  };

  my.users = {
    ivabus.enable = false;
    user.enable = true;
  };

  my.features.secrets = false;

  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "powersave";
  };

  # system is very slow without it
  security.allowSimultaneousMultithreading = lib.mkForce true;

  system.stateVersion = "23.05";
}
