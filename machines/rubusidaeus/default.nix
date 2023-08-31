
{ config, pkgs, lib, ... }:

let
  my = import ../..;
  overlay = final: super: {
    makeModulesClosure = x:
      super.makeModulesClosure (x // { allowMissing = true; });
  };
in {
  imports = [
    # Not using ./hardware.nix as additional hardware file due to generation of images that doesn't change between installations. Maybe I should create dedicated raspberry.nix for all raspberry pies.
    my.modules
  ];

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  sdImage.compressImage = false;

  networking.hostName = "rubusidaeus";

  my.laptop.enable = false;
  my.roles = {
    design.enable = false;
    devel.enable = false;
    gaming.enable = false;
    graphical.enable = false;
    latex.enable = false;
    media-client.enable = false;
    torrent.enable = false;
    virtualisation.enable = false;
    yggdrasil-client.enable = true;
  };

  # Augghhh

  nixpkgs.overlays = [ overlay ];

  networking.useDHCP = true;

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.05";
}

