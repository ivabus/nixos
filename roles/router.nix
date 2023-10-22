{ config, lib, pkgs, ... }:

let
  cfg = config.my.roles.router;
  ipv6_subnet = "2a05:3580:e41a:d600";
  ipv6_prefix = 64;
  ipv4_subnet = "192.168";
  ipv4_prefix = 24;
in {
  options.my.roles.router.enable =
    lib.mkEnableOption "Enable router capabilities";

  options.my.roles.router.interfaces.wan = lib.mkOption {
    type = lib.types.str;
    default = "wan0";
    description = ''
      WAN interface name.
    '';
  };
  options.my.roles.router.interfaces.lan = lib.mkOption {
    type = lib.types.str;
    default = "lan0";
    description = ''
      LAN interface name.
    '';
  };
  options.my.roles.router.addresses.ipv4.subnet = lib.mkOption {
    type = lib.types.str;
    default = "192.168";
    description = ''
      IPv4 subnet to allocate (currently only with /24 mask)
    '';
  };

  config = lib.mkIf (cfg.enable) {
    boot.kernel.sysctl = lib.mkForce {
      "net.ipv4.conf.all.forwarding" = true;
      "net.ipv6.conf.all.forwarding" = true;

      "net.ipv6.conf.all.accept_ra" = 0;
      "net.ipv6.conf.all.autoconf" = 0;
      "net.ipv6.conf.all.use_tempaddr" = 0;

      # On WAN, allow IPv6 autoconfiguration and tempory address use.
      "net.ipv6.conf.${cfg.interfaces.wan}.accept_ra" = 2;
      "net.ipv6.conf.${cfg.interfaces.wan}.autoconf" = 1;
    };
    services = {
      avahi = {
        enable = true;
        allowInterfaces = [ "${cfg.interfaces.lan}" ];
        ipv4 = true;
        ipv6 = true;
        reflector = true;
      };
      dhcpd4 = {
        enable = true;
        interfaces = [ "${cfg.interfaces.lan}" ];
        extraConfig = ''
          option domain-name-servers 1.1.1.1, 8.8.8.8;
          option subnet-mask 255.255.255.0;

          subnet 192.168.1.0 netmask 255.255.255.0 {
            option broadcast-address 192.168.1.255;
            option routers 192.168.1.1;
            interface ${cfg.interfaces.lan};
            range 192.168.1.64 192.168.1.254;
          }
        '';
      };
    };

    networking = {
      useNetworkd = false;
      useDHCP = false;
      interfaces = {
        "${cfg.interfaces.lan}" = {
          ipv4.addresses = [
            {
              address = "${ipv4_subnet}.0.1";
              prefixLength = 24;
            }
            {
              address = "${ipv4_subnet}.1.1";
              prefixLength = 24;
            }
          ];
        };
        "${cfg.interfaces.wan}".useDHCP = true;
      };
      nat = {
        enable = true;
        externalInterface = "${cfg.interfaces.wan}";
        internalInterfaces = [ "${cfg.interfaces.lan}" ];
        internalIPs = [ "192.168.0.0/24" "192.168.1.0/24" ];
      };
    };
  };
}
