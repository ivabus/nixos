{ config, pkgs, lib, ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;

    # Cute banner, r-right?
    banner = ''

      Authorized access only!

      If you are not authorized to access or use this system, disconnect now!

    '';
  };
  environment.systemPackages = lib.mkIf config.my.roles.graphical.enable [ pkgs.waypipe ];
  programs.ssh.startAgent = true;
}
