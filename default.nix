rec {
  common = import ./common;
  roles = import ./roles;
  features = import ./features.nix;
  secrets = import ./secrets.nix;

  modules = { pkgs, ... }: { imports = [ features common roles ]; };
}
