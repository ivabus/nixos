
{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "stella";
  time.timeZone = "Europe/Moscow";

  services.xserver.videoDrivers=["amdgpu"];
  boot.initrd.kernelModules=["amdgpu"];

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  system.stateVersion = "23.05";
}

