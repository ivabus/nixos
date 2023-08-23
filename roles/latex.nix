{ config, pkgs, lib, ... }:

let
  cfg = config.my.roles.latex;
in {
  options.my.roles.latex.enable = lib.mkEnableOption "Enable latex stuff";
  config = lib.mkIf (cfg.enable){
    environment.systemPackages = with pkgs; [
      # Maybe I don't need to use -full variant of texlive
      # I should find distribution I actually need
      texlive.combined.scheme-full
    ];
  };
}