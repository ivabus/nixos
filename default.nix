rec {
  common = import ./common;
  roles = import ./roles;

  modules = { pkgs, ... }: rec {
    imports = [
      common
      roles
    ];
  };
}