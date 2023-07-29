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
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    curl
    usbutils
    pciutils
    coreutils-full
    killall
    git-crypt
    python3Minimal
  ];

}