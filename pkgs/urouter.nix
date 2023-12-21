{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform, fetchCrate ? pkgs.fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "urouter";
  version = "0.5.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-4+p5CicHzpU15c6aK5R5cf5e0gxWoWf/5jhxDrD0Po8=";
  };

  cargoSha256 = "sha256-9qEu9EzQ5jpMa9veY/ozUWiOVCgs6iZ6AJsZb/dHgDo=";

  nativeBuildInputs = [ pkgs.pkg-config ];
}
