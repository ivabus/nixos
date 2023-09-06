{ config, lib, pkgs, ... }:

let cfg = config.my.roles.design;
in {
  options.my.roles.design.enable =
    lib.mkEnableOption "Enable design-specific programs";
  config = lib.mkIf (cfg.enable) {
    environment.systemPackages = with pkgs; [ inkscape gimp imagemagick ];
  };
}
