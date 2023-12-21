{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform, fetchCrate ? pkgs.fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "urouter";
  version = "0.4.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-KhluExV7RP6+L5ZC9inu0tFsM4Gk3yuaM6EZud0O3Qs=";
  };

  cargoSha256 = "sha256-dSMDsh5gH9jbwfnrL+WHwFPr+rk/z/A5drsX4BdXv18=";

  nativeBuildInputs = [ pkgs.pkg-config ];
}
