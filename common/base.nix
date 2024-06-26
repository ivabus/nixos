{ config, pkgs, lib, nur, ... }:

let
  my = import ../.;
  secrets = my.secrets { inherit config; };
in {
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      sandbox = true;
      trusted-users = [ "root" "ivabus" ];
      allowed-users = [ "root" "ivabus" ];
    };
  };

  nixpkgs.overlays = [ nur.overlay ];

  documentation = {
    doc.enable = false;
    info.enable = false;
    man.enable = true;
    nixos.enable = false;
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    git-crypt
    neovim
    python3
    usbutils
    pciutils
    coreutils
    killall
  ];
  # Inject secrets through module arguments while evaluating configs.
  _module.args.secrets = secrets;
}
