{ ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    
    # Cute banner, right?
    banner = ''

Authorized access only!

If you are not authorized to access or use this system, disconnect now!

    '';
  };

  # TODO: I don't use it
  programs.mosh.enable = true;
}