{ config, pkgs, lib, ... }:

{
  config = lib.mkMerge [{
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = with pkgs; [
        rustc
        cargo
        rustup
        vscode
        clang
        llvm
        lld
        python3Full
        automake
        autoconf
        meson
        ninja
      ];
    }

    (lib.mkIf (!pkgs.stdenv.isAarch64) {boot.binfmt.emulatedSystems = [ "aarch64-linux" ];})
    (lib.mkIf (!pkgs.stdenv.isx86_64) {boot.binfmt.emulatedSystems = [ "x86_64-linux" ];})
  ];
}