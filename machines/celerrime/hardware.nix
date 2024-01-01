{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [ "usb_storage" "xhci_pci" "usbhid" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/679b5c29-3e7f-4449-96f0-7e5890302e32";
    fsType = "btrfs";
  };

  boot.initrd.luks.devices."nixos-root".device =
    "/dev/disk/by-uuid/845370c8-5841-4c9e-b50b-c3a70f6fd2b6";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/2AC0-1B04";
    fsType = "vfat";
  };

  swapDevices = [{
    device = "/dev/disk/by-partuuid/8bd4586f-e44b-41b3-a060-52ba7773237f";
    randomEncryption.enable = true;
  }];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
