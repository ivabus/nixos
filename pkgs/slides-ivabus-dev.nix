{ pkgs ? import <nixpkgs> { }, ... }:
let
  version = "107f8e0d7e02449bc47bbc6fb03f7d1ce2fae60b";
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
