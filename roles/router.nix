{ config, lib, pkgs, ... }:

let cfg = config.my.roles.router;
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
      nat = {
        enable = true;
        externalInterface = "${cfg.interfaces.wan}";
        internalInterfaces = [ "${cfg.interfaces.lan}" ];
        internalIPs = [ "192.168.0.0/24" "192.168.1.0" /24 ];
      };
    };
  };
}
