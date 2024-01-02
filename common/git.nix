{ config, pkgs, lib, ... }:

let cfg = config.my.git;
in {
  options = { my.git.enable = lib.mkEnableOption "Enable git configuration"; };

  config = lib.mkIf (cfg.enable && config.my.users.ivabus.enable) {
    home-manager.users.ivabus = {
      programs.git = {
        enable = true;
        userName = "Ivan Bushchik";
        userEmail = "ivabus@ivabus.dev";
        signing.key = "2F16FBF3262E090C";
        signing.signByDefault = true;
        package = pkgs.gitAndTools.gitFull;
        extraConfig = {
          core.editor = "nvim";
        };
      };
    };
  };
}
