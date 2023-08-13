{ crossSystem ? "aarch64-unknown-linux-musl" }:

let pkgs = import <nixpkgs> {
  crossSystem = {
    config = crossSystem;
  };
};
in
  pkgs.pkgsStatic.callPackage (
    {mkShell, pkg-config, zlib, file}:
    mkShell {
      nativeBuildInputs = [ pkg-config file];
      buildInputs = [ zlib ];
    }
  ) {}
