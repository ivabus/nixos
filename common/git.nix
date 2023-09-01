{ config, pkgs, lib, ... }:

let
  cfg = config.my.git;
in {
  options = {
    my.git.enable = lib.mkEnableOption "Enable git configuration";
  };

  config = lib.mkIf (cfg.enable) {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users.ivabus = {
      programs.git = {
        enable = true;
        userName = "Ivan Bushchik";
        userEmail = "ivabus@ivabus.dev";
        signing.key = "2F16FBF3262E090C";
        signing.signByDefault = true;
        package = pkgs.gitAndTools.gitFull;
      };
      home.stateVersion = "23.05";
    };
  };
}