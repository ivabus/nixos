rec {
  common = import ./common;
  roles = import ./roles;
  secrets = import ./secrets.nix;

  modules = { pkgs, ... }: {
    imports = [
      common
      roles
    ];
  };
}
