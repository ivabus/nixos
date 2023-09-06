{ pkgs, config, lib, ... }:

let cfg = config.my.roles.virtualisation;
in {
  options.my.roles.virtualisation.enable =
    lib.mkEnableOption "Enable tools for virtualisation";
  config = lib.mkIf (cfg.enable) {
    # TODO: Think if I ever need virtualisation
    virtualisation.libvirtd.enable = true;
    environment.systemPackages = with pkgs; [ qemu_full qemu-utils ];
  };
}
