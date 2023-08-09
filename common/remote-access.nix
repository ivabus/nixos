{ ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    banner = ''

Authorized access only!

If you are not authorized to access or use this system, disconnect now!

    '';
  };
  programs.mosh.enable = true;
}