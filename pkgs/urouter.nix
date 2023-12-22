{ pkgs ? import <nixpkgs> { system = builtins.currentSystem; }, lib ? pkgs.lib
, rustPlatform ? pkgs.rustPlatform, fetchCrate ? pkgs.fetchCrate }:

rustPlatform.buildRustPackage rec {
  pname = "urouter";
  version = "0.5.3";

  src = fetchCrate {
    inherit pname version;
    sha256 = "sha256-8vQaaIn5mmaUM8KGtCx0HBVSWOz7dhVkaAU5AHU859Y=";
  };

  cargoSha256 = "sha256-toNctf5EeLEAX3IEmekqgl13Wh6x9YKKQvjPcxBa2VA=";

  nativeBuildInputs = [ pkgs.pkg-config ];
}
