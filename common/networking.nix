{ pkgs, ... }:

{
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General = {
      # Enable DHCP in IWD, TODO: don't do it
      EnableNetworkConfiguration = true;
    };
  };

  # TODO: setup DoH or DoT
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];

  networking.enableIPv6 = true;

  services.resolved.enable = true;
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

  services.timesyncd.enable = true;
  networking.timeServers = [ "ntp1.vniiftri.ru" "0.ru.pool.ntp.org" "0.pool.ntp.org" ];

  # Useful tools
  boot.kernelModules = [ "af_packet" ];
  environment.systemPackages = with pkgs; [ mtr tcpdump traceroute ];
}
