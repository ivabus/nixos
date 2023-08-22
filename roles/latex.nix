{ config, pkgs, lib, ... }:

let
  cfg = config.my.roles.latex;
in {
  options.my.roles.latex.enable = lib.mkEnableOption "Enable latex stuff";
  config = lib.mkIf (cfg.enable){
    environment.systemPackages = with pkgs; [
      texlive.combined.scheme-full
    ];
  };
}