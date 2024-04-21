{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform, fetchCrate ? pkgs.fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "urouter";
  version = "0.7.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-2fPrZ4jn9bt7VwSnBXW65sTcrb+pcpMgexpGnz2n12w=";
  };

  cargoSha256 = "sha256-8bOX/aFSLWqLdjqpZA67iqaJMIQRMPRK38gbI9//tD8=";

  nativeBuildInputs = [ pkgs.pkg-config ];
}
