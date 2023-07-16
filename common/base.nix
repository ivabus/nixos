{ config, pkgs, ... }:

{

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      auto-optimise-store = true;
      trusted-users = [ "root" "@wheel" ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    curl
    usbutils
    usbmuxd
    pciutils
    coreutils-full
  ];

  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];

  i18n.defaultLocale = "ru_RU.UTF-8";
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u16b.psf.gz";
    keyMap = "us";
    packages = with pkgs; [ terminus_font ];
  };

}