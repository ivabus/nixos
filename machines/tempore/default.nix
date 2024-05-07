{ config, pkgs, lib, secrets, ... }:

let my = import ../..;
in {
  imports = [
    ./hardware.nix # Use nixos-generate-config --show-hardware-config > /etc/nixos/machines/MACHINE/hardware.nix
    my.modules
  ];

  networking.hostName = "tempore";
  services.qemuGuest.enable = true;

  # All "my" options
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
    torrent.enable = false;
    virtualisation.enable = false;
    yggdrasil-client.enable = true;

    server = {
      ivabus-dev.enable = false;
      slides-ivabus-dev.enable = false;
      urouter.enable = false;
    };
  };
  my.users = {
    ivabus.enable = true;
    ivabus.dotfiles.enable = true;
    user.enable = false;
  };
  my.features.secrets = true;

  networking.useDHCP = true;

  networking.nat.enable = true;
  networking.nat.externalInterface = "ens3";
  networking.nat.internalInterfaces = [ "wg0" ];
  networking.firewall = { allowedUDPPorts = [ 51820 ]; };

  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.1/24" ];
      listenPort = 51820;

      postSetup = ''
        ${pkgs.iptables}/bin/iptables -t nat -A POSTROUTING -s 10.100.0.0/24 -o ens3 -j MASQUERADE
      '';

      postShutdown = ''
        ${pkgs.iptables}/bin/iptables -t nat -D POSTROUTING -s 10.100.0.0/24 -o ens3 -j MASQUERADE
      '';

      privateKey = secrets.wireguard.privateKey;

      peers = secrets.wireguard.peers;
    };
  };

  system.stateVersion = "23.05";
}
