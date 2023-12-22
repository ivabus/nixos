{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform, fetchCrate ? pkgs.fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "urouter";
  version = "0.5.1";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-3dSH56Asyp9znhmrJAe25ne7EgEMTG7N7XxXgjzxmW0=";
  };

  cargoSha256 = "sha256-mFR8GB4bL20kCWuqmwEec3qAZXr+fu0n0vhnenuFomA=";

  nativeBuildInputs = [ pkgs.pkg-config ];
}
