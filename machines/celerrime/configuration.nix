{ config, pkgs, ... }:

{
  imports = [  ];
  networking.hostName = "celerrime";
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
}
