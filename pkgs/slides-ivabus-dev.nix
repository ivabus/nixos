{ pkgs ? import <nixpkgs> { }, ... }:
let
  version = "797b04b9901c6803ef568551d6159792a2405b1c";
  repo = builtins.fetchGit {
    url = "https://github.com/ivabus/slides.ivabus.dev";
    rev = version;
  };
in pkgs.stdenv.mkDerivation {
  inherit version;
  name = "slides-ivabus-dev";
  src = repo;

  buildInputs = [ ];
  nativeBuildInputs = with pkgs; [ rsync ];

  installPhase = ''
    mkdir -p $out
    rsync -a . $out/ --exclude README.md --exclude LICENSE
  '';
}
