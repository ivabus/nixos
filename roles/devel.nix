{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    jetbrains.clion
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
