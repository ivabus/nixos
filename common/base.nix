{ config, pkgs, lib, ... }:

let
  my = import ../.;
  secrets = my.secrets { inherit config; };
in {
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
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
    [ wget curl git git-crypt neovim python3Full ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      usbutils
      pciutils
      coreutils
      killall
    ];
  # Inject secrets through module arguments while evaluating configs.
  _module.args.secrets = secrets;
}
