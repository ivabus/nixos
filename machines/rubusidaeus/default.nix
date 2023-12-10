{ config, pkgs, lib, secrets, ... }:

let
  my = import ../..;
  ipv6_subnet = "2a05:3580:e41a:d600";
  ipv6_prefix = 64;
  ipv4_gateway = "192.168.1.1";
  ipv4_address = "192.168.1.3";
  ipv4_prefix = 24;
in {
  imports = [ my.modules ../../hardware/rpi4.nix ];

  networking.hostName = "rubusidaeus";

  my.laptop.enable = false;
  my.git.enable = false;
  my.roles = {
    design.enable = false;
    devel.enable = false;
    gaming.enable = false;
    graphical.enable = false;
    graphical.basic.enable = false;
    latex.enable = false;
    media-client.enable = false;
    ntp-server.enable = true;
    torrent.enable = false;
    virtualisation.enable = false;
    yggdrasil-client.enable = true;

    server = { ivabus-dev.enable = true; };
  };

  my.users = {
    ivabus.enable = true;
    user.enable = false;
  };

  my.features.secrets = true;

  networking = {
    useNetworkd = false;
    useDHCP = false;
    interfaces = {
      end0 = {
        ipv6.addresses = [{
          address = "${ipv6_subnet}::1337";
          prefixLength = ipv6_prefix;
        }];
        ipv4.addresses = [{
          address = ipv4_address; # Ughhhhh yep, flat network
          prefixLength = ipv4_prefix;
        }];
      };
    };
    defaultGateway = ipv4_gateway; # should set this things through let...
  };

  # Semi-static configuration, needs rethinking
  services.nginx = {
    virtualHosts."iva.bz" = {
      locations."/".proxyPass = "http://${secrets.maas-address}:8081";
      enableACME = true;
      addSSL = true;
      http3 = true;
      serverAliases = [ "www.iva.bz" ];
    };
    virtualHosts."xn--80acbx2cl.xn--p1ai" = {
      locations."/".proxyPass = "http://${secrets.maas-address}:8083";
      enableACME = true;
      addSSL = true;
      http3 = true;
      serverAliases = [ "ивабус.рф" ];
    };
    virtualHosts."music.ivabus.dev" = {
      locations."/".proxyPass = "http://${secrets.maas-address}:4533";
      enableACME = true;
      forceSSL = true;
      http3 = true;
    };
    virtualHosts."storage.ivabus.dev" = {
      locations."/".proxyPass = "http://${secrets.maas-address}:80";
      enableACME = true;
      forceSSL = true;
      http3 = true;
    };
    virtualHosts."slides.ivabus.dev" = {
      locations."/".proxyPass = "http://${secrets.maas-address}:80";
      enableACME = true;
      forceSSL = true;
      http3 = true;
    };
    virtualHosts."git.ivabus.dev" = {
      locations."/".proxyPass = "http://${secrets.maas-address}:3000";
      enableACME = true;
      forceSSL = true;
      http3 = true;
    };
  };

  hardware.enableRedistributableFirmware = true;
  system.stateVersion = "23.05";
}

