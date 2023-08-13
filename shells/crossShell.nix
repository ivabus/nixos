{ crossSystem ? "aarch64-unknown-linux-musl" }:

let pkgs = import <nixpkgs> {
  crossSystem = {
    config = crossSystem;
  };
};
in
  pkgs.callPackage (
    {mkShell, pkg-config, zlib}:
    mkShell {
      nativeBuildInputs = [ pkg-config ];
      buildInputs = [ zlib ];
    }
  ) {}
