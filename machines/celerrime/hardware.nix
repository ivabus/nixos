{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "usb-storage"
    "xhci_pci"
    "usbhid"
    "mmc_block"
    "xhci_hcd"
    "xhci_plat_hcd"
    "hid_generic"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "uhid" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/4b0a6b8a-a85c-4256-9d83-e46d47e0d017";
    fsType = "btrfs";
    options = [ "compress=zstd" "noatime" ];
  };

  boot.initrd.luks.devices."nixos-root".device =
    "/dev/disk/by-uuid/528c8aa3-d15d-4b23-bbb5-d21cd3edee4b";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/A65B-1700";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/dev/disk/by-partuuid/6d6e837c-d63c-4254-afff-88b69787024f";
    randomEncryption.enable = true;
  }];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
