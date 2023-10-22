{ pkgs ? import <nixpkgs> { }, bundlerEnv, ... }:
let
  version = "52e142e05270dd4adca1ec364b3e31f4c64cd485";
  repo = builtins.fetchGit {
    url = "https://github.com/ivabus/website";
    rev = version;
  };

  gems = bundlerEnv {
    name = "ivabus-dev";
    ruby = pkgs.ruby;

    gemdir = "${repo}/.";
  };
in pkgs.stdenv.mkDerivation {
  inherit version;
  name = "ivabus-dev";
  src = repo;

  buildInputs = with pkgs; [
    gems
    # nokogiri dependencies
    zlib
    libiconv
    libxml2
    libxslt
    # jekyll wants a JS runtime
    nodejs-slim
  ];

  buildPhase = ''
    bundle exec jekyll build 
  '';

  installPhase = ''
    mkdir -p $out
    cp -r _site/* $out/
  '';
}
