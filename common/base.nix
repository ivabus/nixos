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
      substituters = [
        "https://binarycache.ivabus.dev/public" # Yep, only public one here :)
	"https://cache.nixos.org"
      ];
      trusted-public-keys = [
        "public:9k8+78y5+1rICy+9e4raIiLP/dKDEvm9dyjj27vPS04="
      ];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
    daemonCPUSchedPolicy = "idle";
    daemonIOSchedClass = "idle";
  };

  documentation = {
    doc.enable = false;
    info.enable = false;
    man.enable = true;
    nixos.enable = false;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    usbutils
    pciutils
    coreutils-full
    killall
    git
    git-crypt
    neovim
    python3Minimal
  ];

  boot.tmp.cleanOnBoot = true;
}
