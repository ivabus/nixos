{ config, pkgs, lib, ... }:


let
  x86 = pkgs.stdenv.isx86_64;
in {
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
  ];
}
