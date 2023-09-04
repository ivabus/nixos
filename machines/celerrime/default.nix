{ config, pkgs, ... }:

let
  my = import ../..;
in {
  imports = [
    ./hardware.nix
    my.modules
  ];

  networking.hostName = "celerrime";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  # Enable screen space near notch
  boot.kernelParams = [ "apple_dcp.show_notch=1" ];

  my.laptop.enable = true;
  my.git.enable = true;
  my.roles = {
    design.enable = true;
    devel.enable = true;
    gaming.enable = false;
    graphical.enable = true;
    latex.enable = true;
    media-client.enable = true;
    torrent.enable = true;
    virtualisation.enable = false;
    yggdrasil-client.enable = true;
  };

  networking.useDHCP = true;

  # Setup asahi-specific things. NOTE: you must copy firmware from ESP to /etc/nixos/asahi/firmware
  hardware.asahi.peripheralFirmwareDirectory = ../../asahi/firmware;
  hardware.asahi.addEdgeKernelConfig = true;
  hardware.asahi.useExperimentalGPUDriver = true;

  environment.systemPackages = with pkgs; [
    (retroarch.override { cores = with libretro; [ np2kai ];})
  ];

  services.nginx = {
    enable = true;
    # Use recommended settings
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;

    virtualHosts."ivabus.dev" = {
      # i don't want to call package like this
      root = pkgs.callPackage ../../pkgs/ivabus-dev.nix {};

      extraConfig = ''
        error_page 404 /404.html;
      '';
    };
  };

  system.stateVersion = "23.05";
}
