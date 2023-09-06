{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "xhci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" "nct6775" ];
  boot.extraModulePackages = [ ];

  environment.etc = {
    "sysconfig/lm_sensors".text = ''
            HWMON_MODULES="lm75"
      	'';
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/e9d47776-8f25-490b-9ea3-ee80ab9d6110";
    fsType = "btrfs";
  };

  boot.initrd.luks.devices."cryptroot".device =
    "/dev/disk/by-uuid/c2e3757b-b29c-4797-9535-084eb71351e9";

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4F73-6FFF";
    fsType = "vfat";
  };

  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
