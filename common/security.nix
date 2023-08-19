{ lib, ... }:

{
  systemd.coredump.enable = false;

  security = {
    lockKernelModules = true;
    protectKernelImage = true;
    allowSimultaneousMultithreading = true;
    forcePageTableIsolation = false;
    virtualisation.flushL1DataCache = "always";
    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
    };

    allowUserNamespaces = true;
    
  };

  boot.kernel.sysctl = {
    "kernel.sysrq" = 0;
    "net.ipv4.icmp_ignore_bogus_error_responces" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;

    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;

    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;

    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_rfc1337" = 1;

    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

  boot.kernelModules = [ "tcp_bbr" ];
}
