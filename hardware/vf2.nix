{ config, pkgs, lib, ... }:

let
  overlay = final: super: {
    makeModulesClosure = x:
      super.makeModulesClosure (x // {
        allowMissing = true;
      }); # Ignores missing kernel modules (can't build image without this fix)
    # Overflow tests fail
    diffutils = super.diffutils.override { doCheck = false; };
  };
in {
  boot = {
    kernelParams = [
      "console=tty0"
      "console=ttyS0,115200"
      "earlycon=sbi"
      "boot.shell_on_fail"
    ];
    supportedFilesystems = lib.mkForce [ "ext4" ];
    initrd.includeDefaultModules = false;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
      "dw_mmc-pltfm"
      "dw_mmc-starfive"
      "dwmac-starfive"
      "spi-dw-mmio"
      "mmc_block"
      "nvme"
      "sdhci"
      "sdhci-pci"
      "sdhci-of-dwcmshc"
    ];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
  systemd.services."serial-getty@hvc0".enable = false;
  systemd.services."serial-getty@ttyS0" = {
    enable = true;
    wantedBy = [ "getty.target" ];
    serviceConfig.Restart = "always";
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
  };

  sdImage.compressImage = false;

  hardware.enableRedistributableFirmware = true;
}

