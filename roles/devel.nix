{ config, pkgs, lib, rust-overlay, ... }:

let cfg = config.my.roles.devel;
in {
  options.my.roles.devel.enable =
    lib.mkEnableOption "Enable tools for development programs";
  config = lib.mkIf (cfg.enable) (lib.mkMerge [
    {
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ rust-overlay.overlays.default ];
      environment.systemPackages = with pkgs; [
        (rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" ];
          targets = [
            pkgs.stdenv.hostPlatform.config
            "x86_64-unknown-linux-musl"
            "aarch64-unknown-linux-musl"
            "riscv64gc-unknown-linux-gnu" # Musl version is tier 3, so no automatic builds
          ];
        })
        clang
        llvm
        lld
        gnumake
        automake
        autoconf
        meson
        ninja
        picocom
        screen
        hyperfine
        nixfmt
        sshfs
      ];
    }
    /* # Will be reenabled
       # Architecture-specific packages and configuration
       (lib.mkIf (!pkgs.stdenv.isAarch64) {
         boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
       })
       (lib.mkIf (!pkgs.stdenv.isAarch32) {
         boot.binfmt.emulatedSystems = [ "armv6l-linux" ];
       })
       (lib.mkIf (!pkgs.stdenv.isx86_64) {
         boot.binfmt.emulatedSystems = [ "x86_64-linux" "i686-linux" ];
       })
    */

    /* # Install CLion only if we are on x86_64
        (lib.mkIf (pkgs.stdenv.isx86_64) {
          environment.systemPackages = with pkgs; [ jetbrains.clion ];
        })
    */
    # Install vscode only if we are on x86_64 or aarch64 or aarch32
    (lib.mkIf
      (pkgs.stdenv.isx86_64 || pkgs.stdenv.isAarch64 || pkgs.stdenv.isAarch32) {
        environment.systemPackages = with pkgs; [ vscode-fhs ];
      })
  ]);
}
