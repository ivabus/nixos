{ config, pkgs, lib, ... }:

{
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
