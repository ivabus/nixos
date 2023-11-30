{ pkgs, lib, ... }:

{
  networking.firewall.allowPing = true;

  networking.useNetworkd = lib.mkDefault true;
  systemd.network.wait-online.enable = lib.mkDefault false;

  # Use systemd-resolved for DoT support.
  services.resolved = {
    enable = true;
    dnssec = "false";
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };

  # Used by systemd-resolved, not directly by resolv.conf.
  networking.nameservers =
    [ "1.0.0.1#cloudflare-dns.com" "8.8.8.8#dns.google" ];

  networking.enableIPv6 = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    publish = {
      enable = true;
      addresses = true;
      domain = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };
  };

  services.chrony.enable = true;
  networking.timeServers =
    [ "ntp1.vniiftri.ru" "0.ru.pool.ntp.org" "0.pool.ntp.org" ];

  # Useful tools
  boot.kernelModules = [ "af_packet" ];
  environment.systemPackages = with pkgs; [ mtr tcpdump traceroute ];
}
