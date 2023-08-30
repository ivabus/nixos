{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "usb_storage" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/aed0b311-8954-4164-afc3-9e7c6a2d8c2a";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/8551d309-afe6-4a25-b571-b2cb1eff7c09";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/771E-1309";
      fsType = "vfat";
    };

  swapDevices =
    [ {
      device = "/dev/disk/by-partuuid/dace6477-697e-4bba-aede-eb0e9f7a28ff";
      randomEncryption.enable = true;
    } ];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "ondemand";
}
