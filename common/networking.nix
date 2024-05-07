{ pkgs, lib, ... }:

{
  networking.firewall.allowPing = true;

  networking.useNetworkd = lib.mkDefault true;
  systemd.network.wait-online.enable = lib.mkDefault false;

  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];

  networking.enableIPv6 = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
    };
  };

  services.chrony.enable = true;
  networking.timeServers = [
    "89.109.251.21"
    "89.109.251.22"
    "ntp1.vniiftri.ru"
    "0.ru.pool.ntp.org"
    "0.pool.ntp.org"
  ];

  # Useful tools
  boot.kernelModules = [ "af_packet" ];
  environment.systemPackages = with pkgs; [ mtr tcpdump traceroute ];
}
