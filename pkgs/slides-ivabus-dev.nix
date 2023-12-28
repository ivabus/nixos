{ pkgs ? import <nixpkgs> { }, ... }:
let
  version = "004b77657f36a8d681a49d3573604312ef052949";
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
