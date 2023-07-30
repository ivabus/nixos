{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "apple_dcp.show_notch=1" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/c313a438-700c-4d9c-9413-354ebfb010eb";
      fsType = "btrfs";
    };

  boot.initrd.luks.devices."nixos-root".device = "/dev/disk/by-uuid/871dcf57-eee1-4dde-846d-e856c92f70c8";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6CCA-1404";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/272341f1-b083-497e-b129-aef8732b5b50"; }
    ];
  hardware.asahi.peripheralFirmwareDirectory = ../../asahi/firmware;
  hardware.asahi.addEdgeKernelConfig = true;
  hardware.asahi.useExperimentalGPUDriver = true;
  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
