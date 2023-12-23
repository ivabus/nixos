{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform, fetchCrate ? pkgs.fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "urouter";
  version = "0.6.0";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-KfoZ9NinD6PCL4M3U4sB8GHdbDLeRW7uFeQpGxmzJ90=";
  };

  cargoSha256 = "sha256-VfoF4hzWf5j2QtXyS/jFYCMfowl47YcAjxs2PV9C6oo=";

  nativeBuildInputs = [ pkgs.pkg-config ];
}
