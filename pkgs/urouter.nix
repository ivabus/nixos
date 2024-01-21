{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform, fetchCrate ? pkgs.fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "urouter";
  version = "0.6.1";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-1HKAqX15gvfzUFpyt0FFq9NZog1XSgeEYCrGVu4lSKM=";
  };

  cargoSha256 = "sha256-e/gVAmLhHhkPqxanTSz/qrayJUlBcFT0/WjA726H0bk=";

  nativeBuildInputs = [ pkgs.pkg-config ];
}
