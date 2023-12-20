{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform, fetchCrate ? pkgs.fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "urouter";
  version = "0.3.5";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-kLCJXLtcbF3IeTylbd7EpDx3cjt0sRz1P90iJYlLi7Y=";
  };

  cargoSha256 = "sha256-zePizgFOoSDILz8PL74RQ+iPFXJY+l41M4EwLwzJRPU=";

  nativeBuildInputs = [ pkgs.pkg-config ];
}
