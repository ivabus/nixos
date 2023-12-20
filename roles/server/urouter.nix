{ config, lib, pkgs, ... }:
let
  cfg = config.my.roles.server.urouter;
  aliasFormat = pkgs.formats.json { };
in {
  options.my.roles.server.urouter = {
    enable = lib.mkEnableOption "Enable urouter";
    settings = lib.mkOption rec {
      type = aliasFormat.type;
      apply = lib.recursiveUpdate default;
      default = { alias = [ ]; };
      example = {
        alias = [
          {
            uri = "/";
            alias = "https://someurl";
            is_url = true;
          }
          {
            uri = "/";
            alias = "some_file";
            curl_only = true;
          }
        ];
      };
      description = lib.mdDoc ''
        alias.json configuration in Nix format.
      '';
    };

    dir = lib.mkOption {
      type = lib.types.str;
      default = "/var/urouter";
      example = "/home/user/urouter";
    };

    address = lib.mkOption {
      type = lib.types.str;
      default = "0.0.0.0";
      example = "0200::1";
    };

    port = lib.mkOption {
      type = lib.types.ints.u16;
      default = 8080;
      example = 80;
    };

    openFirewall = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = lib.mdDoc "Whether to open the TCP port in the firewall";
    };
  };
  config = lib.mkIf (cfg.enable) {
    networking.firewall.allowedTCPPorts =
      lib.mkIf cfg.openFirewall [ cfg.port ];

    systemd.services.urouter = {
      description = "urouter HTTP Service";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        ExecStart = ''
          ${
            pkgs.callPackage ../../pkgs/urouter.nix { }
          }/bin/urouter --alias-file-is-set-not-a-list --alias-file ${
            aliasFormat.generate "alias.json" cfg.settings
          } --dir ${cfg.dir} --address ${cfg.address} --port ${
            builtins.toString cfg.port
          }
        '';
        BindReadOnlyPaths = [ cfg.dir ];
      };
    };
  };
}
