{ config, pkgs, lib, ... }:

let
  cfg = config.my.roles.devel;
in {
  options.my.roles.devel.enable = lib.mkEnableOption "Enable tools for development programs";
  config = lib.mkIf (cfg.enable) ( lib.mkMerge [{
      nixpkgs.config.allowUnfree = true;
      environment.systemPackages = with pkgs; [
        rustc
        cargo
        rustup
        clang
        llvm
        lld
        python3Full
        gnumake
        automake
        autoconf
        meson
        ninja
        picocom
        screen
      ];
    }
    # Architecture-specific packages and configuration
    (lib.mkIf (!pkgs.stdenv.isAarch64) {boot.binfmt.emulatedSystems = [ "aarch64-linux" ];})
    (lib.mkIf (!pkgs.stdenv.isAarch32) {boot.binfmt.emulatedSystems = [ "armv6l-linux" ];})
    (lib.mkIf (!pkgs.stdenv.isx86_64) {boot.binfmt.emulatedSystems = [ "x86_64-linux" "i686-linux" ];})
    # Remove CLion from builds while I'm semi-online
    # Install CLion only if we are on x86_64
    /*(lib.mkIf (pkgs.stdenv.isx86_64) {
      environment.systemPackages = with pkgs; [
        jetbrains.clion
      ];
    })*/
    # Install vscode only if we are on x86_64 or aarch64 or aarch32
    (lib.mkIf (pkgs.stdenv.isx86_64 || pkgs.stdenv.isAarch64 || pkgs.stdenv.isAarch32) {
      environment.systemPackages = with pkgs; [
        vscode
      ];
    })
  ]);
}
