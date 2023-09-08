{ config, pkgs, lib, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      auto-optimise-store = true;
      allowed-users = [ "root" "@wheel" ];
      trusted-users = [ "root" "@wheel" ];
      sandbox = true;
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  documentation = {
    doc.enable = false;
    info.enable = false;
    man.enable = true;
  };

  environment.systemPackages = with pkgs;
    [ wget curl git git-crypt neovim python3Minimal nixfmt ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      usbutils
      pciutils
      coreutils-full
      killall
    ];

}
