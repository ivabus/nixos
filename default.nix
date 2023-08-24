rec {
  common = import ./common;
  roles = import ./roles;

  modules = { pkgs, ... }: {
    imports = [
      common
      roles
    ];
  };
}