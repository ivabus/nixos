{ config, pkgs, lib, ... }:

let
  overlay = final: super: {
    makeModulesClosure = x:
      super.makeModulesClosure (x // {
        allowMissing = true;
      }); # Ignores missing kernel modules (can't build image without this fix)
  };
in {

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [ "xhci_pci" "usbhid" "usb_storage" ];
    supportedFilesystems = lib.mkForce [ "ext4" "vfat" ];
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

  # Augghhh (activates fix)
  nixpkgs.overlays = [ overlay ];

  hardware.enableRedistributableFirmware = true;
}

