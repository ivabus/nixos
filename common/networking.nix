{ ... }:

{
  networking.wireless.iwd.enable = true;
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = true;
    };
  };

  networking.nameservers = [ "1.1.1.1" "1.0.0.1" "8.8.8.8" ];

  networking.enableIPv6 = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
  };

  services.timesyncd.enable = true;
  networking.timeServers = [ "ntp1.vniiftri.ru" "0.ru.pool.ntp.org" "0.pool.ntp.org" ];
}
