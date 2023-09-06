{ ... }:

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
}
